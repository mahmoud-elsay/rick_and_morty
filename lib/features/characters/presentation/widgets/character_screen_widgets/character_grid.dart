import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/core/theming/color_manger.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_screen_widgets/character_card.dart';

class CharacterGridWidget extends StatelessWidget {
  final List<Character> characters;
  final Set<int> favoriteCharacterIds;
  final ScrollController scrollController;
  final Function(int) onToggleFavorite;
  final Function(Character) onCharacterTap;
  final bool isLoadingMore;

  const CharacterGridWidget({
    super.key,
    required this.characters,
    required this.favoriteCharacterIds,
    required this.scrollController,
    required this.onToggleFavorite,
    required this.onCharacterTap,
    required this.isLoadingMore,
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
        itemCount: isLoadingMore ? characters.length + 1 : characters.length,
        itemBuilder: (context, index) {
          if (isLoadingMore && index == characters.length) {
            return _buildLoadingIndicator();
          }

          final character = characters[index];
          final isFavorite = favoriteCharacterIds.contains(character.id);

          return CharacterCard(
            character: character,
            isFavorite: isFavorite,
            onToggleFavorite: () => onToggleFavorite(character.id),
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
    return _ShimmerTile(height: double.infinity);
  }
}

class _ShimmerTile extends StatefulWidget {
  final double height;

  const _ShimmerTile({required this.height});

  @override
  State<_ShimmerTile> createState() => _ShimmerTileState();
}

class _ShimmerTileState extends State<_ShimmerTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-1 + _controller.value * 2, -1),
                end: Alignment(1 + _controller.value * 2, 1),
                colors: [
                  ColorManager.spaceshipDark.withOpacity(0.2),
                  ColorManager.portalGreen.withOpacity(0.08),
                  ColorManager.spaceshipDark.withOpacity(0.2),
                ],
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
          );
        },
      ),
    );
  }
}
