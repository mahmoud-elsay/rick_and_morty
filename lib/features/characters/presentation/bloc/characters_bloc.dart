import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty/core/helpers/debouncer.dart';
import 'package:rick_and_morty/core/network/api_result.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';
import 'package:rick_and_morty/features/characters/presentation/bloc/characters_event.dart';
import 'package:rick_and_morty/features/characters/presentation/bloc/characters_state.dart';
import 'package:rick_and_morty/features/characters/domain/usecases/toggle_favorite_usecase.dart';
import 'package:rick_and_morty/features/characters/domain/usecases/fetch_characters_usecase.dart';
import 'package:rick_and_morty/features/characters/domain/repositories/character_repository.dart';
import 'package:rick_and_morty/features/characters/domain/usecases/search_characters_usecase.dart';
import 'package:rick_and_morty/features/characters/domain/usecases/filter_characters_usecase.dart';


class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final FetchCharactersUsecase _fetchCharactersUsecase;
  final SearchCharactersUsecase _searchCharactersUsecase;
  final FilterCharactersUsecase _filterCharactersUsecase;
  final ToggleFavoriteUsecase _toggleFavoriteUsecase;
  final CharacterRepository _repository;
  final Debouncer _debouncer;

  int _currentPage = 1;
  StreamSubscription? _connectivitySubscription;
  Timer? _searchTimer;

  CharactersBloc(
    this._fetchCharactersUsecase,
    this._searchCharactersUsecase,
    this._filterCharactersUsecase,
    this._toggleFavoriteUsecase,
    this._repository,
    this._debouncer,
  ) : super(const CharactersState.initial()) {
    on<CharactersEvent>((event, emit) async {
      await event.map(
        loadCharacters: (e) => _onLoadCharacters(e, emit),
        loadMoreCharacters: (e) => _onLoadMoreCharacters(e, emit),
        searchCharacters: (e) => _onSearchCharacters(e, emit),
        filterCharacters: (e) => _onFilterCharacters(e, emit),
        toggleFavorite: (e) => _onToggleFavorite(e, emit),
        connectivityChanged: (e) => _onConnectivityChanged(e, emit),
      );
    });

    // Listen to connectivity changes
    _connectivitySubscription = _repository.connectivityStream.listen(
      (isOnline) => add(CharactersEvent.connectivityChanged(isOnline)),
    );
  }

  Future<void> _onLoadCharacters(
    LoadCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    if (event.isRefresh) {
      _currentPage = 1;
    } else {
      emit(const CharactersState.loading());
    }

    final favoriteIds = Set<int>.from(
      await _toggleFavoriteUsecase.getFavorites(),
    );

    final result = await _fetchCharactersUsecase(page: _currentPage);

    result.when(
      success: (characters) {
        emit(
          CharactersState.loaded(
            characters: characters,
            favoriteIds: favoriteIds,
            hasReachedMax: characters.isEmpty,
          ),
        );
      },
      failure: (error) {
        // Try to load cached data
        _loadCachedData(
          emit,
          favoriteIds,
          error.apiErrorModel.message ?? 'Unknown error',
        );
      },
    );
  }

  Future<void> _onLoadMoreCharacters(
    LoadMoreCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    final currentState = state;
    if (currentState is CharactersLoaded &&
        !currentState.hasReachedMax &&
        !currentState.isLoadingMore) {
      emit(currentState.copyWith(isLoadingMore: true));

      _currentPage++;

      final result = await _fetchCharactersUsecase(page: _currentPage);

      result.when(
        success: (newCharacters) {
          final hasReachedMax = newCharacters.isEmpty;
          final updatedCharacters = [...currentState.characters];

          // Avoid duplicates
          for (final character in newCharacters) {
            if (!updatedCharacters.any((c) => c.id == character.id)) {
              updatedCharacters.add(character);
            }
          }

          emit(
            currentState.copyWith(
              characters: updatedCharacters,
              hasReachedMax: hasReachedMax,
              isLoadingMore: false,
            ),
          );
        },
        failure: (error) {
          _currentPage--; // Revert page increment on error
          emit(currentState.copyWith(isLoadingMore: false));
        },
      );
    }
  }

  Future<void> _onSearchCharacters(
    SearchCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    // Cancel previous search timer
    _searchTimer?.cancel();

    // Debounce search
    _searchTimer = Timer(const Duration(milliseconds: 400), () async {
      final currentState = state;
      if (currentState is CharactersLoaded) {
        emit(currentState.copyWith(currentSearchQuery: event.query));

        _currentPage = 1;

        final result = await _searchCharactersUsecase(
          query: event.query,
          page: _currentPage,
        );

        result.when(
          success: (characters) {
            emit(
              currentState.copyWith(
                characters: characters,
                hasReachedMax: characters.isEmpty,
                currentSearchQuery: event.query,
              ),
            );
          },
          failure: (error) {
            _loadCachedData(
              emit,
              currentState.favoriteIds,
              error.apiErrorModel.message ?? 'Search failed',
            );
          },
        );
      }
    });
  }

  Future<void> _onFilterCharacters(
    FilterCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    final currentState = state;
    if (currentState is CharactersLoaded) {
      emit(currentState.copyWith(currentFilter: event.status));

      _currentPage = 1;

      final result = await _filterCharactersUsecase(
        status: event.status,
        page: _currentPage,
        searchQuery: currentState.currentSearchQuery.isEmpty
            ? null
            : currentState.currentSearchQuery,
      );

      result.when(
        success: (characters) {
          emit(
            currentState.copyWith(
              characters: characters,
              hasReachedMax: characters.isEmpty,
              currentFilter: event.status,
            ),
          );
        },
        failure: (error) {
          _loadCachedData(
            emit,
            currentState.favoriteIds,
            error.apiErrorModel.message ?? 'Filter failed',
          );
        },
      );
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<CharactersState> emit,
  ) async {
    await _toggleFavoriteUsecase(event.characterId);

    final currentState = state;
    if (currentState is CharactersLoaded) {
      final updatedFavorites = Set<int>.from(currentState.favoriteIds);

      if (updatedFavorites.contains(event.characterId)) {
        updatedFavorites.remove(event.characterId);
      } else {
        updatedFavorites.add(event.characterId);
      }

      emit(currentState.copyWith(favoriteIds: updatedFavorites));
    }
  }

  Future<void> _onConnectivityChanged(
    ConnectivityChanged event,
    Emitter<CharactersState> emit,
  ) async {
    final currentState = state;
    if (currentState is CharactersLoaded) {
      emit(currentState.copyWith(isOnline: event.isOnline));
    }
  }

  Future<void> _loadCachedData(
    Emitter<CharactersState> emit,
    Set<int> favoriteIds,
    String errorMessage,
  ) async {
    final cachedCharacters = await _repository.getCachedCharacters(
      _currentPage,
    );

    if (cachedCharacters.isNotEmpty) {
      emit(
        CharactersState.loaded(
          characters: cachedCharacters,
          favoriteIds: favoriteIds,
          isOnline: false,
        ),
      );
    } else {
      emit(CharactersState.error(
        message: errorMessage,
        favoriteIds: favoriteIds,
      ));
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    _searchTimer?.cancel();
    return super.close();
  }
}