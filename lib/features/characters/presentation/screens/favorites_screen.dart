import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/core/helpers/extensions.dart';
import 'package:rick_and_morty/core/routes/routes_name.dart';
import 'package:rick_and_morty/core/theming/text_styles.dart';
import 'package:rick_and_morty/core/theming/color_manger.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';
import 'package:rick_and_morty/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:rick_and_morty/features/characters/presentation/bloc/characters_event.dart';
import 'package:rick_and_morty/features/characters/presentation/bloc/characters_state.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_screen_widgets/character_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Character> favoriteCharacters = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final favorites =
            ModalRoute.of(context)?.settings.arguments as List<Character>? ??
            [];
        setState(() {
          favoriteCharacters = List<Character>.from(favorites);
        });
      }
    });
  }

  void _handleFavoriteToggle(int characterId) {
    if (!mounted) return;

    // Update local state immediately for smooth UI
    setState(() {
      favoriteCharacters.removeWhere(
        (character) => character.id == characterId,
      );
    });

    // Update the BLoC state
    context.read<CharactersBloc>().add(ToggleFavorite(characterId));
  }

  void _navigateToDetails(Character character) async {
    if (!mounted) return;

    try {
      await context.pushNamed(
        Routes.characterDetailsScreen,
        arguments: character,
      );

      // Check if character is still favorited after returning from details
      final state = context.read<CharactersBloc>().state;
      if (state is CharactersLoaded && mounted) {
        if (!state.favoriteIds.contains(character.id)) {
          setState(() {
            favoriteCharacters.removeWhere((char) => char.id == character.id);
          });
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error navigating to details: $e'),
            backgroundColor: ColorManager.dangerRed,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CharactersBloc, CharactersState>(
      listener: (context, state) {
        if (state is CharactersLoaded && mounted) {
          // Update local favorite list when BLoC state changes
          setState(() {
            favoriteCharacters = favoriteCharacters
                .where((char) => state.favoriteIds.contains(char.id))
                .toList();
          });
        }
      },
      child: Scaffold(
        backgroundColor: ColorManager.cosmicBlack,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorManager.cosmicBlack,
                ColorManager.spaceshipDark.withOpacity(0.8),
                ColorManager.cosmicBlack,
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                _buildAppBar(),
                verticalSpace(20),
                Expanded(child: _buildContent()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorManager.spaceshipDark.withOpacity(0.1),
            Colors.transparent,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () {
              if (mounted) {
                Navigator.pop(context);
              }
            },
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: ColorManager.spaceshipDark.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: ColorManager.portalGreen.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.arrow_back_ios,
                color: ColorManager.portalGreen,
                size: 20.sp,
              ),
            ),
          ),
          horizontalSpace(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [ColorManager.portalGreen, ColorManager.sciFiBlue],
                  ).createShader(bounds),
                  child: Text(
                    'Favorites',
                    style: TextStyles.whitePoppins24Medium.copyWith(
                      color: ColorManager.labWhite,
                    ),
                  ),
                ),
                Text(
                  '${favoriteCharacters.length} Characters',
                  style: TextStyles.whitePoppins12Regular.copyWith(
                    color: ColorManager.labWhite.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (favoriteCharacters.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorManager.portalGreen.withOpacity(0.1),
                    ColorManager.sciFiBlue.withOpacity(0.1),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.favorite_border,
                size: 48.sp,
                color: ColorManager.asteroidGrey,
              ),
            ),
            verticalSpace(16),
            Text(
              'No favorites yet',
              style: TextStyles.whitePoppins18Medium.copyWith(
                color: ColorManager.labWhite,
              ),
            ),
            verticalSpace(8),
            Text(
              'Tap the heart icon to add characters',
              style: TextStyles.whitePoppins14Regular.copyWith(
                color: ColorManager.asteroidGrey,
              ),
            ),
            verticalSpace(20),
            ElevatedButton.icon(
              onPressed: () {
                if (mounted) {
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Go Back'),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.portalGreen.withOpacity(0.2),
                foregroundColor: ColorManager.portalGreen,
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
          childAspectRatio: 0.75,
        ),
        itemCount: favoriteCharacters.length,
        itemBuilder: (context, index) {
          final character = favoriteCharacters[index];
          return CharacterCard(
            character: character,
            isFavorite: true,
            onToggleFavorite: () => _handleFavoriteToggle(character.id),
            onTap: () => _navigateToDetails(character),
          );
        },
      ),
    );
  }
}
