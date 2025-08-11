import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/core/helpers/extensions.dart';
import 'package:rick_and_morty/core/routes/routes_name.dart';
import 'package:rick_and_morty/core/theming/text_styles.dart';
import 'package:rick_and_morty/core/theming/color_manger.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_screen_widgets/character_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Map<String, dynamic>> favoriteCharacters = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final favorites =
          ModalRoute.of(context)?.settings.arguments
              as List<Map<String, dynamic>>? ??
          [];
      setState(() {
        favoriteCharacters = List.from(favorites);
      });
    });
  }

  void _removeFavorite(int characterId) {
    setState(() {
      favoriteCharacters.removeWhere(
        (character) => character['id'] == characterId,
      );
    });

    // Send back the update to the characters screen
    Navigator.pop(context, {'id': characterId, 'isFavorite': false});
  }

  // Navigate to character details and handle the result
  void _navigateToDetails(Map<String, dynamic> character) async {
    final result =
        await context.pushNamed(
              Routes.characterDetailsScreen,
              arguments: character,
            )
            as Map<String, dynamic>?;

    // If character was unfavorited in details screen, remove it from this list
    if (result != null &&
        result.containsKey('id') &&
        result.containsKey('isFavorite')) {
      final characterId = result['id'] as int;
      final isFavorite = result['isFavorite'] as bool;

      if (!isFavorite) {
        setState(() {
          favoriteCharacters.removeWhere((char) => char['id'] == characterId);
        });
      }

      // Also pass this information back to characters screen
      Navigator.pop(context, result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onTap: () => Navigator.pop(context),
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
            onToggleFavorite: () => _removeFavorite(character['id']),
            onTap: () => _navigateToDetails(character),
          );
        },
      ),
    );
  }
}
