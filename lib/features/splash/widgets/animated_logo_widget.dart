import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/core/theming/text_styles.dart';
import 'package:rick_and_morty/core/theming/color_manger.dart';

class AnimatedLogoWidget extends StatelessWidget {
  final Animation<Offset> slideAnimation;
  final Animation<double> fadeAnimation;

  const AnimatedLogoWidget({
    super.key,
    required this.slideAnimation,
    required this.fadeAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slideAnimation,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: Column(
          children: [
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  ColorManager.portalGreen,
                  ColorManager.sciFiBlue,
                  ColorManager.portalGreen,
                ],
                stops: const [0.0, 0.5, 1.0],
              ).createShader(bounds),
              child: Text(
                'RICK & MORTY',
                style: TextStyles.whitePoppins32Medium.copyWith(
                  color: ColorManager.labWhite,
                  letterSpacing: 3.0,
                  shadows: [
                    Shadow(
                      color: ColorManager.portalGreen.withOpacity(0.5),
                      offset: const Offset(0, 2),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'MULTIVERSE EXPLORER',
              style: TextStyles.whitePoppins15Light.copyWith(
                letterSpacing: 2.0,
                color: ColorManager.labWhite.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}