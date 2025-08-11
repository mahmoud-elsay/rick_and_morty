import 'package:rick_and_morty/core/network/api_result.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';
import 'package:rick_and_morty/features/characters/domain/repositories/character_repository.dart';

class GetCharacterDetailsUsecase {
  final CharacterRepository _repository;

  GetCharacterDetailsUsecase(this._repository);

  Future<ApiResult<Character>> call(int characterId) async {
    return await _repository.getCharacterById(characterId);
  }
}
