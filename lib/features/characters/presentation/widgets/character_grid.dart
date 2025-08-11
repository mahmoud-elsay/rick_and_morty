import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/core/theming/color_manger.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_card.dart';

class CharacterGridWidget extends StatelessWidget {
  final List<Map<String, dynamic>> characters;
  final Set<int> favoriteCharacterIds;
  final ScrollController scrollController;
  final Function(int) onToggleFavorite;
  final Function(Map<String, dynamic>) onCharacterTap;

  const CharacterGridWidget({
    super.key,
    required this.characters,
    required this.favoriteCharacterIds,
    required this.scrollController,
    required this.onToggleFavorite,
    required this.onCharacterTap,
  });

  @override
  Widget build(BuildContext context) {
    if (characters.isEmpty) {
      return _buildEmptyState();
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: GridView.builder(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
          childAspectRatio: 0.75,
        ),
        itemCount: characters.length + 1,
        itemBuilder: (context, index) {
          if (index == characters.length) {
            return _buildLoadingIndicator();
          }

          final character = characters[index];
          final isFavorite = favoriteCharacterIds.contains(character['id']);

          return CharacterCard(
            character: character,
            isFavorite: isFavorite,
            onToggleFavorite: () => onToggleFavorite(character['id']),
            onTap: () => onCharacterTap(character),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
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
              Icons.search_off,
              size: 48.sp,
              color: ColorManager.asteroidGrey,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'No characters found',
            style: TextStyle(
              fontSize: 18.sp,
              color: ColorManager.labWhite,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Try adjusting your search or filters',
            style: TextStyle(fontSize: 14.sp, color: ColorManager.asteroidGrey),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      margin: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.spaceshipDark.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: ColorManager.asteroidGrey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 24.w,
              height: 24.h,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  ColorManager.portalGreen,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Loading...',
              style: TextStyle(
                fontSize: 12.sp,
                color: ColorManager.asteroidGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
