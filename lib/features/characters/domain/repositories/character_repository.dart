import 'package:rick_and_morty/core/network/api_result.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';

abstract class CharacterRepository {
  Future<ApiResult<List<Character>>> getCharacters({
    int page = 1,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
  });

  Future<ApiResult<Character>> getCharacterById(int id);

  Future<List<Character>> getCachedCharacters(int page);

  Future<List<Character>> searchCachedCharacters(String query);

  Future<void> toggleFavorite(int characterId);

  Future<List<int>> getFavorites();

  Future<bool> isFavorite(int characterId);

  Future<void> clearCache();

  Stream<bool> get connectivityStream;
}
