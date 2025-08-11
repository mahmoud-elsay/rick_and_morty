import 'package:rick_and_morty/core/network/api_result.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';
import 'package:rick_and_morty/features/characters/domain/repositories/character_repository.dart';

class FilterCharactersUsecase {
  final CharacterRepository _repository;

  FilterCharactersUsecase(this._repository);

  Future<ApiResult<List<Character>>> call({
    required String status,
    int page = 1,
    String? searchQuery,
  }) async {
    return await _repository.getCharacters(
      page: page,
      name: searchQuery,
      status: status == 'All' ? null : status.toLowerCase(),
    );
  }
}
