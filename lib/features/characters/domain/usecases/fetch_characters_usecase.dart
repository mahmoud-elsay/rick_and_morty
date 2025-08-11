import 'package:rick_and_morty/core/network/api_result.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';
import 'package:rick_and_morty/features/characters/domain/repositories/character_repository.dart';

class FetchCharactersUsecase {
  final CharacterRepository _repository;

  FetchCharactersUsecase(this._repository);

  Future<ApiResult<List<Character>>> call({
    int page = 1,
    String? name,
    String? status,
  }) async {
    return await _repository.getCharacters(
      page: page,
      name: name,
      status: status,
    );
  }
}
