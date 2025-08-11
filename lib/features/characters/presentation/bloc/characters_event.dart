import 'package:freezed_annotation/freezed_annotation.dart';

part 'characters_event.freezed.dart';

@freezed
class CharactersEvent with _$CharactersEvent {
  const factory CharactersEvent.loadCharacters({
    @Default(false) bool isRefresh,
  }) = LoadCharacters;
  const factory CharactersEvent.loadMoreCharacters() = LoadMoreCharacters;
  const factory CharactersEvent.searchCharacters(String query) =
      SearchCharacters;
  const factory CharactersEvent.filterCharacters(String status) =
      FilterCharacters;
  const factory CharactersEvent.toggleFavorite(int characterId) =
      ToggleFavorite;
  const factory CharactersEvent.connectivityChanged(bool isOnline) =
      ConnectivityChanged;
}
