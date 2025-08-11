import 'package:rick_and_morty/core/network/api_result.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';
import 'package:rick_and_morty/features/characters/domain/repositories/character_repository.dart';

class SearchCharactersUsecase {
  final CharacterRepository _repository;

  SearchCharactersUsecase(this._repository);

  Future<ApiResult<List<Character>>> call({
    required String query,
    int page = 1,
  }) async {
    return await _repository.getCharacters(
      page: page,
      name: query.isNotEmpty ? query : null,
    );
  }
}
