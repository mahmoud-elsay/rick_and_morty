import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/core/theming/text_styles.dart';
import 'package:rick_and_morty/core/theming/color_manger.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  final Animation<double> portalAnimation;

  const LoadingIndicatorWidget({
    super.key,
    required this.portalAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: portalAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: portalAnimation.value,
          child: Column(
            children: [
              SizedBox(
                width: 40.w,
                height: 40.h,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    ColorManager.portalGreen,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Loading Dimensions...',
                style: TextStyles.whitePoppins15Light.copyWith(
                  color: ColorManager.labWhite.withOpacity(0.7),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}