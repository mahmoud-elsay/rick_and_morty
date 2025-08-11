import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/core/theming/text_styles.dart';
import 'package:rick_and_morty/core/theming/color_manger.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_details_screen_widgets/hero_image.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_details_screen_widgets/status_badge.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_details_screen_widgets/shimmer_overlay.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';
// features/characters/presentation/widgets/character_details_screen_widgets/character_details_app_bar.dart

class CharacterDetailsAppBar extends StatelessWidget {
  final Character character;
  final Color statusColor;
  final Animation<double> heroAnimation;
  final Animation<double> shimmerAnimation;
  final VoidCallback onBack;

  const CharacterDetailsAppBar({
    super.key,
    required this.character,
    required this.statusColor,
    required this.heroAnimation,
    required this.shimmerAnimation,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 400.h,
      pinned: true,
      backgroundColor: ColorManager.cosmicBlack.withOpacity(0.9),
      leading: Container(
        margin: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: ColorManager.cosmicBlack.withOpacity(0.8),
          shape: BoxShape.circle,
          border: Border.all(
            color: ColorManager.portalGreen.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: ColorManager.labWhite,
            size: 20.sp,
          ),
          onPressed: onBack,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    statusColor.withOpacity(0.2),
                    ColorManager.cosmicBlack.withOpacity(0.8),
                    ColorManager.cosmicBlack,
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
              ),
            ),
            ShimmerOverlay(shimmerAnimation: shimmerAnimation),
            Center(
              child: HeroImage(
                character: character,
                statusColor: statusColor,
                heroAnimation: heroAnimation,
              ),
            ),
            Positioned(
              top: 80.h,
              right: 60.w,
              child: StatusBadge(
                status: character.status,
                statusColor: statusColor,
                heroAnimation: heroAnimation,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
