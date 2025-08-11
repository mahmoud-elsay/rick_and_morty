import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rick_and_morty/core/network/dio_factory.dart';
import 'package:rick_and_morty/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:rick_and_morty/features/characters/data/repos/character_repository_impl.dart';
import 'package:rick_and_morty/features/characters/data/datasources/local/hive_data_source.dart';
import 'package:rick_and_morty/features/characters/domain/usecases/toggle_favorite_usecase.dart';
import 'package:rick_and_morty/features/characters/domain/repositories/character_repository.dart';
import 'package:rick_and_morty/features/characters/domain/usecases/fetch_characters_usecase.dart';
import 'package:rick_and_morty/features/characters/domain/usecases/search_characters_usecase.dart';
import 'package:rick_and_morty/features/characters/domain/usecases/filter_characters_usecase.dart';
import 'package:rick_and_morty/features/characters/data/datasources/remote/rick_and_morty_api.dart';
import 'package:rick_and_morty/features/characters/domain/usecases/get_character_details_usecase.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // External dependencies
  getIt.registerLazySingleton<Dio>(() => DioFactory.getDio());
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());

  // Data sources
  getIt.registerLazySingleton<RickAndMortyApi>(
    () => RickAndMortyApi(getIt<Dio>()),
  );
  getIt.registerLazySingleton<HiveDataSource>(() => HiveDataSource());

  // Repository
  getIt.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(
      getIt<RickAndMortyApi>(),
      getIt<HiveDataSource>(),
      getIt<Connectivity>(),
    ),
  );

  // Use cases
  getIt.registerLazySingleton<FetchCharactersUsecase>(
    () => FetchCharactersUsecase(getIt<CharacterRepository>()),
  );
  getIt.registerLazySingleton<SearchCharactersUsecase>(
    () => SearchCharactersUsecase(getIt<CharacterRepository>()),
  );
  getIt.registerLazySingleton<FilterCharactersUsecase>(
    () => FilterCharactersUsecase(getIt<CharacterRepository>()),
  );
  getIt.registerLazySingleton<ToggleFavoriteUsecase>(
    () => ToggleFavoriteUsecase(getIt<CharacterRepository>()),
  );
  getIt.registerLazySingleton<GetCharacterDetailsUsecase>(
    () => GetCharacterDetailsUsecase(getIt<CharacterRepository>()),
  );

  // BLoC
  getIt.registerFactory<CharactersBloc>(
    () => CharactersBloc(
      getIt<FetchCharactersUsecase>(),
      getIt<SearchCharactersUsecase>(),
      getIt<FilterCharactersUsecase>(),
      getIt<ToggleFavoriteUsecase>(),
      getIt<CharacterRepository>(),
    ),
  );
}
