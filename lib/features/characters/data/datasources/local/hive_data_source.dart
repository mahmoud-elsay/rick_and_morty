import 'package:hive/hive.dart';
import 'package:rick_and_morty/features/characters/data/models/character_response_model.dart';

class HiveDataSource {
  static const String _charactersBox = 'characters';
  static const String _favoritesBox = 'favorites';
  static const String _paginationBox = 'pagination';

  // Cache characters by page
  Future<void> cacheCharacters(
    int page,
    List<CharacterModel> characters,
  ) async {
    final box = await Hive.openBox<List>(_charactersBox);
    await box.put('page_$page', characters.map((c) => c.toJson()).toList());
  }

  // Get cached characters by page
  Future<List<CharacterModel>?> getCachedCharacters(int page) async {
    try {
      final box = await Hive.openBox<List>(_charactersBox);
      final cachedData = box.get('page_$page');
      if (cachedData != null) {
        return cachedData
            .map(
              (json) =>
                  CharacterModel.fromJson(Map<String, dynamic>.from(json)),
            )
            .toList();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Cache search results
  Future<void> cacheSearchResults(
    String query,
    List<CharacterModel> characters,
  ) async {
    final box = await Hive.openBox<List>(_charactersBox);
    await box.put('search_$query', characters.map((c) => c.toJson()).toList());
  }

  // Get cached search results
  Future<List<CharacterModel>?> getCachedSearchResults(String query) async {
    try {
      final box = await Hive.openBox<List>(_charactersBox);
      final cachedData = box.get('search_$query');
      if (cachedData != null) {
        return cachedData
            .map(
              (json) =>
                  CharacterModel.fromJson(Map<String, dynamic>.from(json)),
            )
            .toList();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Favorites management
  Future<void> addToFavorites(int characterId) async {
    final box = await Hive.openBox<List<int>>(_favoritesBox);
    final favorites = box.get('favorites', defaultValue: <int>[])!;
    if (!favorites.contains(characterId)) {
      favorites.add(characterId);
      await box.put('favorites', favorites);
    }
  }

  Future<void> removeFromFavorites(int characterId) async {
    final box = await Hive.openBox<List<int>>(_favoritesBox);
    final favorites = box.get('favorites', defaultValue: <int>[])!;
    favorites.remove(characterId);
    await box.put('favorites', favorites);
  }

  Future<List<int>> getFavorites() async {
    final box = await Hive.openBox<List<int>>(_favoritesBox);
    return box.get('favorites', defaultValue: <int>[])!;
  }

  Future<bool> isFavorite(int characterId) async {
    final favorites = await getFavorites();
    return favorites.contains(characterId);
  }

  // Cache pagination info
  Future<void> cachePaginationInfo(
    String key,
    int totalPages,
    int currentPage,
  ) async {
    final box = await Hive.openBox<Map>(_paginationBox);
    await box.put(key, {'totalPages': totalPages, 'currentPage': currentPage});
  }

  Future<Map<String, int>?> getCachedPaginationInfo(String key) async {
    try {
      final box = await Hive.openBox<Map>(_paginationBox);
      final data = box.get(key);
      if (data != null) {
        return {
          'totalPages': data['totalPages'] as int,
          'currentPage': data['currentPage'] as int,
        };
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Clear all cached data
  Future<void> clearCache() async {
    await Hive.deleteBoxFromDisk(_charactersBox);
    await Hive.deleteBoxFromDisk(_paginationBox);
  }

  // Clear search cache
  Future<void> clearSearchCache() async {
    final box = await Hive.openBox<List>(_charactersBox);
    final keys = box.keys
        .where((key) => key.toString().startsWith('search_'))
        .toList();
    for (final key in keys) {
      await box.delete(key);
    }
  }
}
