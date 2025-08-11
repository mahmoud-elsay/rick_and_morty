import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rick_and_morty/core/network/api_result.dart';
import 'package:rick_and_morty/core/network/api_error_handler.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';
import 'package:rick_and_morty/features/characters/data/datasources/local/hive_data_source.dart';
import 'package:rick_and_morty/features/characters/domain/repositories/character_repository.dart';
import 'package:rick_and_morty/features/characters/data/datasources/remote/rick_and_morty_api.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final RickAndMortyApi _api;
  final HiveDataSource _hiveDataSource;
  final Connectivity _connectivity;

  CharacterRepositoryImpl(this._api, this._hiveDataSource, this._connectivity);

  @override
  Stream<bool> get connectivityStream => _connectivity.onConnectivityChanged
      .map((result) => result != ConnectivityResult.none);

  @override
  Future<ApiResult<List<Character>>> getCharacters({
    int page = 1,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
  }) async {
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      final isOnline = connectivityResult != ConnectivityResult.none;

      if (!isOnline) {
        final cachedCharacters = await getCachedCharacters(page);
        final filtered = _applyLocalFilters(cachedCharacters, name, status);
        return ApiResult.success(filtered);
      }

      final response = await _api.getCharacters(
        page: page,
        name: name,
        status: status,
        species: species,
        type: type,
        gender: gender,
      );

      if (response.results.isEmpty) {
        final cachedCharacters = await getCachedCharacters(page);
        if (cachedCharacters.isNotEmpty) {
          return ApiResult.success(cachedCharacters);
        }
        return ApiResult.failure(
          ErrorHandler.handle(Exception('No characters found')),
        );
      }

      final characters = response.results
          .map((model) => model.toEntity())
          .toList();

      try {
        if (name == null &&
            status == null &&
            species == null &&
            type == null &&
            gender == null) {
          await _hiveDataSource.cacheCharacters(page, response.results);
          await _hiveDataSource.cachePaginationInfo(
            'all_characters',
            response.info.pages,
            page,
          );
        } else {
          final query = _buildQueryString(name, status, species, type, gender);
          await _hiveDataSource.cacheSearchResults(query, response.results);
        }
      } catch (_) {
        // Ignore cache errors; still return success
      }

      return ApiResult.success(characters);
    } catch (error) {
      final cachedCharacters = await getCachedCharacters(page);
      final filtered = _applyLocalFilters(cachedCharacters, name, status);
      if (filtered.isNotEmpty || (name != null || status != null)) {
        return ApiResult.success(filtered);
      }
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  @override
  Future<List<Character>> getCachedCharacters(int page) async {
    final cachedModels = await _hiveDataSource.getCachedCharacters(page);
    return cachedModels?.map((model) => model.toEntity()).toList() ?? [];
  }

  @override
  Future<ApiResult<Character>> getCharacterById(int id) async {
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      final isOnline = connectivityResult != ConnectivityResult.none;

      if (!isOnline) {
        Character? found;
        // Try to find character in cached pages (search first few pages)
        for (int page = 1; page <= 5; page++) {
          final cachedCharacters = await getCachedCharacters(page);
          final match = cachedCharacters.where((char) => char.id == id);
          if (match.isNotEmpty) {
            found = match.first;
            break;
          }
        }
        if (found != null) {
          return ApiResult.success(found);
        }
        return ApiResult.failure(
          ErrorHandler.handle(
            Exception('No internet connection and character not cached'),
          ),
        );
      }

      final response = await _api.getCharacterById(id: id);
      return ApiResult.success(response.toEntity());
    } catch (error) {
      // Try to find in cache as fallback
      Character? found;
      for (int page = 1; page <= 5; page++) {
        final cachedCharacters = await getCachedCharacters(page);
        final match = cachedCharacters.where((char) => char.id == id);
        if (match.isNotEmpty) {
          found = match.first;
          break;
        }
      }
      if (found != null) {
        return ApiResult.success(found);
      }
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  @override
  Future<List<Character>> searchCachedCharacters(String query) async {
    try {
      final cachedModels = await _hiveDataSource.getCachedSearchResults(query);
      return cachedModels?.map((model) => model.toEntity()).toList() ?? [];
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> toggleFavorite(int characterId) async {
    try {
      final isFav = await _hiveDataSource.isFavorite(characterId);
      if (isFav) {
        await _hiveDataSource.removeFromFavorites(characterId);
      } else {
        await _hiveDataSource.addToFavorites(characterId);
      }
    } catch (e) {
      throw Exception('Failed to toggle favorite: $e');
    }
  }

  @override
  Future<List<int>> getFavorites() async {
    try {
      return await _hiveDataSource.getFavorites();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> isFavorite(int characterId) async {
    try {
      return await _hiveDataSource.isFavorite(characterId);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await _hiveDataSource.clearCache();
    } catch (e) {
      throw Exception('Failed to clear cache: $e');
    }
  }

  String _buildQueryString(
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
  ) {
    final parts = <String>[];
    if (name != null) parts.add('name:$name');
    if (status != null) parts.add('status:$status');
    if (species != null) parts.add('species:$species');
    if (type != null) parts.add('type:$type');
    if (gender != null) parts.add('gender:$gender');
    return parts.join('_');
  }

  List<Character> _applyLocalFilters(
    List<Character> characters,
    String? name,
    String? status,
  ) {
    Iterable<Character> filtered = characters;
    if (name != null && name.isNotEmpty) {
      final lower = name.toLowerCase();
      filtered = filtered.where((c) => c.name.toLowerCase().contains(lower));
    }
    if (status != null && status.isNotEmpty) {
      final lowerStatus = status.toLowerCase();
      filtered = filtered.where((c) => c.status.toLowerCase() == lowerStatus);
    }
    return filtered.toList();
  }
}
