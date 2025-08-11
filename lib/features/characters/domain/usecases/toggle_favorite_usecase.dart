import 'package:rick_and_morty/features/characters/domain/repositories/character_repository.dart';

class ToggleFavoriteUsecase {
  final CharacterRepository _repository;

  ToggleFavoriteUsecase(this._repository);

  Future<void> call(int characterId) async {
    await _repository.toggleFavorite(characterId);
  }

  Future<bool> isFavorite(int characterId) async {
    return await _repository.isFavorite(characterId);
  }

  Future<List<int>> getFavorites() async {
    return await _repository.getFavorites();
  }
}
