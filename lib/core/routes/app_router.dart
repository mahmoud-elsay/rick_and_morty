import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/routes/routes_name.dart';
import 'package:rick_and_morty/features/splash/splash_screen.dart';
import 'package:rick_and_morty/features/characters/presentation/screens/favorites_screen.dart';
import 'package:rick_and_morty/features/characters/presentation/screens/characters_screen.dart';
import 'package:rick_and_morty/features/characters/presentation/screens/character_details_screen.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.characterDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => CharacterDetailsScreen(character: character),
        );
      case Routes.favoritesScreen:
        final favorites = settings.arguments as List<Character>? ?? [];
        return MaterialPageRoute(
          builder: (_) => FavoritesScreen(),
          settings: RouteSettings(arguments: favorites),
        );
      case Routes.charactersScreen:
        return MaterialPageRoute(builder: (_) => const CharactersScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
