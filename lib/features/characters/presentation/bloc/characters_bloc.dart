import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/network/api_result.dart';
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

  int _currentPage = 1;
  StreamSubscription? _connectivitySubscription;

  CharactersBloc(
    this._fetchCharactersUsecase,
    this._searchCharactersUsecase,
    this._filterCharactersUsecase,
    this._toggleFavoriteUsecase,
    this._repository,
  ) : super(const CharactersState.initial()) {
    on<LoadCharacters>(_onLoadCharacters);
    on<LoadMoreCharacters>(_onLoadMoreCharacters);
    on<SearchCharacters>(_onSearchCharacters);
    on<FilterCharacters>(_onFilterCharacters);
    on<ToggleFavorite>(_onToggleFavorite);
    on<ConnectivityChanged>(_onConnectivityChanged);

    _connectivitySubscription = _repository.connectivityStream.listen(
      (isOnline) => add(CharactersEvent.connectivityChanged(isOnline)),
    );
  }

  Future<void> _onLoadCharacters(
    LoadCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    try {
      if (event.isRefresh) {
        _currentPage = 1;
      } else {
        emit(const CharactersState.loading());
      }

      final favoriteIds = Set<int>.from(
        await _toggleFavoriteUsecase.getFavorites(),
      );

      final result = await _fetchCharactersUsecase(page: _currentPage);

      await result.when(
        success: (characters) async {
          if (emit.isDone) return;
          emit(
            CharactersState.loaded(
              characters: characters,
              favoriteIds: favoriteIds,
              hasReachedMax: characters.isEmpty,
              isOnline: true,
            ),
          );
        },
        failure: (error) async {
          await _loadCachedData(
            emit,
            favoriteIds,
            error.apiErrorModel.message ?? 'Failed to load characters',
            false,
          );
        },
      );
    } catch (e) {
      final favoriteIds = Set<int>.from(
        await _toggleFavoriteUsecase.getFavorites(),
      );
      await _loadCachedData(
        emit,
        favoriteIds,
        'Unexpected error: ${e.toString()}',
        false,
      );
    }
  }

  Future<void> _onLoadMoreCharacters(
    LoadMoreCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is CharactersLoaded &&
          !currentState.hasReachedMax &&
          !currentState.isLoadingMore) {
        emit(currentState.copyWith(isLoadingMore: true));

        _currentPage++;

        final result = await _fetchCharactersUsecase(page: _currentPage);

        await result.when(
          success: (newCharacters) {
            if (emit.isDone) return;

            final hasReachedMax = newCharacters.isEmpty;
            final updatedCharacters = [...currentState.characters]
              ..addAll(
                newCharacters.where(
                  (newChar) =>
                      !currentState.characters.any((c) => c.id == newChar.id),
                ),
              );

            emit(
              currentState.copyWith(
                characters: updatedCharacters,
                hasReachedMax: hasReachedMax,
                isLoadingMore: false,
                isOnline: true,
              ),
            );
          },
          failure: (error) {
            if (emit.isDone) return;
            _currentPage--;
            emit(currentState.copyWith(isLoadingMore: false, isOnline: false));
          },
        );
      }
    } catch (e) {
      final currentState = state;
      if (currentState is CharactersLoaded && !emit.isDone) {
        _currentPage--;
        emit(currentState.copyWith(isLoadingMore: false, isOnline: false));
      }
    }
  }

  Future<void> _onSearchCharacters(
    SearchCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is CharactersLoaded) {
        emit(currentState.copyWith(currentSearchQuery: event.query));

        _currentPage = 1;

        final result = await _searchCharactersUsecase(
          query: event.query,
          page: _currentPage,
        );

        await result.when(
          success: (characters) {
            if (emit.isDone) return;
            emit(
              currentState.copyWith(
                characters: characters,
                hasReachedMax: characters.isEmpty,
                currentSearchQuery: event.query,
                isOnline: true,
              ),
            );
          },
          failure: (error) async {
            await _loadCachedData(
              emit,
              currentState.favoriteIds,
              error.apiErrorModel.message ?? 'Search failed',
              false,
            );
          },
        );
      }
    } catch (e) {
      final currentState = state;
      if (currentState is CharactersLoaded && !emit.isDone) {
        emit(
          currentState.copyWith(
            currentSearchQuery: event.query,
            isOnline: false,
          ),
        );
      }
    }
  }

  Future<void> _onFilterCharacters(
    FilterCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    try {
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

        await result.when(
          success: (characters) {
            if (emit.isDone) return;
            emit(
              currentState.copyWith(
                characters: characters,
                hasReachedMax: characters.isEmpty,
                currentFilter: event.status,
                isOnline: true,
              ),
            );
          },
          failure: (error) async {
            await _loadCachedData(
              emit,
              currentState.favoriteIds,
              error.apiErrorModel.message ?? 'Filter failed',
              false,
            );
          },
        );
      }
    } catch (e) {
      final currentState = state;
      if (currentState is CharactersLoaded && !emit.isDone) {
        emit(
          currentState.copyWith(currentFilter: event.status, isOnline: false),
        );
      }
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<CharactersState> emit,
  ) async {
    try {
      await _toggleFavoriteUsecase(event.characterId);

      final currentState = state;
      if (currentState is CharactersLoaded) {
        final updatedFavorites = Set<int>.from(currentState.favoriteIds);
        updatedFavorites.contains(event.characterId)
            ? updatedFavorites.remove(event.characterId)
            : updatedFavorites.add(event.characterId);

        if (!emit.isDone) {
          emit(currentState.copyWith(favoriteIds: updatedFavorites));
        }
      }
    } catch (e) {
      debugPrint('Error toggling favorite: $e');
    }
  }

  Future<void> _onConnectivityChanged(
    ConnectivityChanged event,
    Emitter<CharactersState> emit,
  ) async {
    final currentState = state;
    if (currentState is CharactersLoaded && !emit.isDone) {
      emit(currentState.copyWith(isOnline: event.isOnline));
    }
  }

  Future<void> _loadCachedData(
    Emitter<CharactersState> emit,
    Set<int> favoriteIds,
    String errorMessage,
    bool isOnline,
  ) async {
    try {
      final cachedCharacters = await _repository.getCachedCharacters(
        _currentPage,
      );

      if (cachedCharacters.isNotEmpty) {
        if (!emit.isDone) {
          emit(
            CharactersState.loaded(
              characters: cachedCharacters,
              favoriteIds: favoriteIds,
              isOnline: isOnline,
            ),
          );
        }
      } else {
        if (!emit.isDone) {
          emit(
            CharactersState.error(
              message: errorMessage,
              favoriteIds: favoriteIds,
              cachedCharacters: cachedCharacters,
              isOnline: isOnline,
            ),
          );
        }
      }
    } catch (e) {
      if (!emit.isDone) {
        emit(
          CharactersState.error(
            message: 'Failed to load cached data: ${e.toString()}',
            favoriteIds: favoriteIds,
            cachedCharacters: [],
            isOnline: isOnline,
          ),
        );
      }
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
