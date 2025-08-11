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
      // Check connectivity
      final connectivityResult = await _connectivity.checkConnectivity();
      final isOnline = connectivityResult != ConnectivityResult.none;

      if (!isOnline) {
        // Return cached data if offline
        final cachedCharacters = await getCachedCharacters(page);
        return ApiResult.success(cachedCharacters);
      }

      // Fetch from API
      final response = await _api.getCharacters(
        page: page,
        name: name,
        status: status,
        species: species,
        type: type,
        gender: gender,
      );

      // Convert to domain entities
      final characters = response.results
          .map((model) => model.toEntity())
          .toList();

      // Cache the results
      if (name == null &&
          status == null &&
          species == null &&
          type == null &&
          gender == null) {
        // Cache regular pagination
        await _hiveDataSource.cacheCharacters(page, response.results);
        await _hiveDataSource.cachePaginationInfo(
          'all_characters',
          response.info.pages,
          page,
        );
      } else {
        // Cache search/filter results
        final query = _buildQueryString(name, status, species, type, gender);
        await _hiveDataSource.cacheSearchResults(query, response.results);
      }

      return ApiResult.success(characters);
    } catch (error) {
      // Return cached data on error
      final cachedCharacters = await getCachedCharacters(page);
      if (cachedCharacters.isNotEmpty) {
        return ApiResult.success(cachedCharacters);
      }
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<Character>> getCharacterById(int id) async {
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      final isOnline = connectivityResult != ConnectivityResult.none;

      if (!isOnline) {
        return ApiResult.failure(
          ErrorHandler.handle(Exception('No internet connection')),
        );
      }

      final response = await _api.getCharacterById(id: id);
      return ApiResult.success(response.toEntity());
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  @override
  Future<List<Character>> getCachedCharacters(int page) async {
    final cachedModels = await _hiveDataSource.getCachedCharacters(page);
    return cachedModels?.map((model) => model.toEntity()).toList() ?? [];
  }

  @override
  Future<List<Character>> searchCachedCharacters(String query) async {
    final cachedModels = await _hiveDataSource.getCachedSearchResults(query);
    return cachedModels?.map((model) => model.toEntity()).toList() ?? [];
  }

  @override
  Future<void> toggleFavorite(int characterId) async {
    final isFav = await _hiveDataSource.isFavorite(characterId);
    if (isFav) {
      await _hiveDataSource.removeFromFavorites(characterId);
    } else {
      await _hiveDataSource.addToFavorites(characterId);
    }
  }

  @override
  Future<List<int>> getFavorites() async {
    return await _hiveDataSource.getFavorites();
  }

  @override
  Future<bool> isFavorite(int characterId) async {
    return await _hiveDataSource.isFavorite(characterId);
  }

  @override
  Future<void> clearCache() async {
    await _hiveDataSource.clearCache();
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
}
