import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';

part 'characters_state.freezed.dart';

@freezed
class CharactersState with _$CharactersState {
  const factory CharactersState.initial() = CharactersInitial;
  const factory CharactersState.loading() = CharactersLoading;

  const factory CharactersState.loaded({
    required List<Character> characters,
    required Set<int> favoriteIds,
    @Default(false) bool hasReachedMax,
    @Default(false) bool isLoadingMore,
    @Default(true) bool isOnline,
    @Default('All') String currentFilter,
    @Default('') String currentSearchQuery,
    Character? selectedCharacter,
  }) = CharactersLoaded;

  const factory CharactersState.error({
    required String message,
    @Default([]) List<Character> cachedCharacters,
    @Default({}) Set<int> favoriteIds,
    @Default(false) bool isOnline,
  }) = CharactersError;

  const factory CharactersState.detailLoaded({
    required Character character,
    required bool isFavorite,
  }) = CharacterDetailLoaded;
}
