import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/core/theming/text_styles.dart';
import 'package:rick_and_morty/core/theming/color_manger.dart';
// features/characters/presentation/widgets/character_details_screen_widgets/episode_card.dart


class EpisodeCard extends StatelessWidget {
  final int index;
  final String episode;

  const EpisodeCard({
    super.key,
    required this.index,
    required this.episode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorManager.spaceshipDark.withOpacity(0.8),
            ColorManager.spaceshipDark.withOpacity(0.4),
          ],
        ),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: ColorManager.portalGreen.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorManager.portalGreen.withOpacity(0.3),
                  ColorManager.sciFiBlue.withOpacity(0.3),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: TextStyles.whitePoppins12Regular.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          horizontalSpace(12),
          Expanded(
            child: Text(
              episode,
              style: TextStyles.whitePoppins15Medium,
            ),
          ),
          Icon(
            Icons.play_arrow,
            color: ColorManager.portalGreen,
            size: 20.sp,
          ),
        ],
      ),
    );
  }
}