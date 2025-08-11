import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:rick_and_morty/core/network/api_constants.dart';
import 'package:rick_and_morty/features/characters/data/models/character_response_model.dart';

part 'rick_and_morty_api.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class RickAndMortyApi {
  factory RickAndMortyApi(Dio dio, {String baseUrl}) = _RickAndMortyApi;

  @GET(ApiConstants.charactersEndpoint)
  Future<CharacterResponseModel> getCharacters({
    @Query('page') int? page,
    @Query('name') String? name,
    @Query('status') String? status,
    @Query('species') String? species,
    @Query('type') String? type,
    @Query('gender') String? gender,
  });

  @GET('${ApiConstants.charactersEndpoint}/{id}')
  Future<CharacterModel> getCharacterById({@Path('id') required int id});
}
