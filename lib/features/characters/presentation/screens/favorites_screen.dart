import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/core/routes/routes_name.dart';
import 'package:rick_and_morty/core/theming/text_styles.dart';
import 'package:rick_and_morty/core/theming/color_manger.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_screen_widgets/character_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteCharacters =
        ModalRoute.of(context)?.settings.arguments
            as List<Map<String, dynamic>>? ??
        [];

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
              Expanded(child: _buildContent(favoriteCharacters)),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(List<Map<String, dynamic>> favorites) {
    if (favorites.isEmpty) {
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
            SizedBox(height: 16.h),
            Text(
              'No favorites yet',
              style: TextStyles.whitePoppins18Medium.copyWith(
                color: ColorManager.labWhite,
              ),
            ),
            SizedBox(height: 8.h),
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
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final character = favorites[index];
          return CharacterCard(
            character: character,
            isFavorite: true,
            onToggleFavorite: () {
              Navigator.pop(context, {
                'id': character['id'],
                'isFavorite': false,
              });
            },
            onTap: () async {
              final result =
                  await Navigator.pushNamed(
                        context,
                        Routes.characterDetailsScreen,
                        arguments: character,
                      )
                      as Map<String, dynamic>?;

              if (result != null) {
                Navigator.pop(context, result);
              }
            },
          );
        },
      ),
    );
  }
}
