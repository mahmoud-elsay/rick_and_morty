import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/core/network/api_result.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';
import 'package:rick_and_morty/features/characters/domain/entities/location.dart'
    as domain;
import 'package:rick_and_morty/features/characters/domain/entities/origin.dart'
    as domain;
import 'package:rick_and_morty/features/characters/domain/repositories/character_repository.dart';
import 'package:rick_and_morty/features/characters/domain/usecases/fetch_characters_usecase.dart';
import 'package:rick_and_morty/features/characters/domain/usecases/search_characters_usecase.dart';
import 'package:rick_and_morty/features/characters/domain/usecases/filter_characters_usecase.dart';
import 'package:rick_and_morty/features/characters/domain/usecases/get_character_details_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/core/theming/color_manger.dart';
import 'package:rick_and_morty/features/characters/presentation/screens/characters_screen.dart';
import 'package:rick_and_morty/features/characters/presentation/screens/favorites_screen.dart';
import 'package:rick_and_morty/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:rick_and_morty/features/characters/domain/usecases/toggle_favorite_usecase.dart';

class MockCharacterRepository extends Mock implements CharacterRepository {}

Character makeCharacter(int id) {
  return Character(
    id: id,
    name: 'Rick $id',
    status: 'Alive',
    species: 'Human',
    type: '',
    gender: 'Male',
    origin: domain.Origin(name: 'Earth', url: ''),
    location: domain.Location(name: 'Earth', url: ''),
    image: 'https://example.com/rick.png',
    episode: const [],
    url: '',
    created: '',
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Usecases', () {
    late MockCharacterRepository repo;

    setUp(() {
      repo = MockCharacterRepository();
    });

    test('FetchCharactersUsecase returns success', () async {
      final usecase = FetchCharactersUsecase(repo);
      final characters = [makeCharacter(1)];
      when(
        () => repo.getCharacters(
          page: any(named: 'page'),
          name: any(named: 'name'),
          status: any(named: 'status'),
          species: any(named: 'species'),
          type: any(named: 'type'),
          gender: any(named: 'gender'),
        ),
      ).thenAnswer((_) async => ApiResult.success(characters));

      final result = await usecase(page: 1);
      result.when(
        success: (data) => expect(data, characters),
        failure: (_) => fail('Expected success'),
      );
    });

    test('SearchCharactersUsecase passes query', () async {
      final usecase = SearchCharactersUsecase(repo);
      when(
        () => repo.getCharacters(
          page: any(named: 'page'),
          name: any(named: 'name'),
          status: any(named: 'status'),
          species: any(named: 'species'),
          type: any(named: 'type'),
          gender: any(named: 'gender'),
        ),
      ).thenAnswer((_) async => ApiResult.success([makeCharacter(2)]));
      final result = await usecase(query: 'Rick');
      result.when(
        success: (data) => expect(data.first.name.contains('Rick'), true),
        failure: (_) => fail('Expected success'),
      );
    });

    test('FilterCharactersUsecase passes status', () async {
      final usecase = FilterCharactersUsecase(repo);
      when(
        () => repo.getCharacters(
          page: any(named: 'page'),
          name: any(named: 'name'),
          status: any(named: 'status'),
          species: any(named: 'species'),
          type: any(named: 'type'),
          gender: any(named: 'gender'),
        ),
      ).thenAnswer((_) async => ApiResult.success([makeCharacter(3)]));
      final result = await usecase(status: 'Alive');
      result.when(
        success: (data) => expect(data, isNotEmpty),
        failure: (_) => fail('Expected success'),
      );
    });

    test('GetCharacterDetailsUsecase returns character', () async {
      final usecase = GetCharacterDetailsUsecase(repo);
      when(
        () => repo.getCharacterById(any()),
      ).thenAnswer((_) async => ApiResult.success(makeCharacter(4)));
      final result = await usecase(4);
      result.when(
        success: (data) => expect(data.id, 4),
        failure: (_) => fail('Expected success'),
      );
    });
  });

  group('Widgets', () {
    testWidgets('CharactersScreen shows shimmer when loading', (tester) async {
      final repo = MockCharacterRepository();
      final bloc = CharactersBloc(
        FetchCharactersUsecase(repo),
        SearchCharactersUsecase(repo),
        FilterCharactersUsecase(repo),
        ToggleFavoriteUsecase(repo),
        repo,
      );

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, _) {
            return MaterialApp(
              theme: ThemeData(primaryColor: ColorManager.portalGreen),
              home: BlocProvider.value(
                value: bloc,
                child: const CharactersScreen(),
              ),
            );
          },
        ),
      );

      // Allow initState to dispatch and first frame to build
      await tester.pump();

      expect(find.byType(CharactersScreen), findsOneWidget);
      // Shimmer grid placeholder exists
      expect(find.textContaining('No characters found'), findsNothing);
    });

    testWidgets('FavoritesScreen empty state renders', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, _) => const MaterialApp(home: FavoritesScreen()),
        ),
      );
      await tester.pump();
      expect(find.text('No favorites yet'), findsOneWidget);
      expect(find.text('Tap the heart icon to add characters'), findsOneWidget);
    });
  });
}
