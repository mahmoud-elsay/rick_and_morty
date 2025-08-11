import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/core/theming/text_styles.dart';
import 'package:rick_and_morty/core/theming/color_manger.dart';
// features/characters/presentation/widgets/character_details_screen_widgets/favorite_fab.dart


class FavoriteFAB extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onPressed;

  const FavoriteFAB({
    super.key,
    required this.isFavorite,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      backgroundColor: Colors.transparent,
      elevation: 0,
      label: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isFavorite
                ? [
                    ColorManager.dangerRed,
                    ColorManager.dangerRed.withOpacity(0.7),
                  ]
                : [ColorManager.portalGreen, ColorManager.sciFiBlue],
          ),
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color:
                  (isFavorite
                          ? ColorManager.dangerRed
                          : ColorManager.portalGreen)
                      .withOpacity(0.4),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: ColorManager.labWhite,
              size: 20.sp,
            ),
            horizontalSpace(8),
            Text(
              isFavorite ? 'Remove from Favorites' : 'Add to Favorites',
              style: TextStyles.whitePoppins15Medium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}