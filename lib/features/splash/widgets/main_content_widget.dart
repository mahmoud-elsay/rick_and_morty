import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/core/theming/text_styles.dart';
import 'package:rick_and_morty/core/theming/color_manger.dart';
import 'package:rick_and_morty/features/splash/widgets/animated_logo_widget.dart';
import 'package:rick_and_morty/features/splash/widgets/loading_indicator_widget.dart';

class MainContentWidget extends StatelessWidget {
  final Animation<double> scaleAnimation;
  final Animation<Offset> slideAnimation;
  final Animation<double> fadeAnimation;
  final Animation<double> portalAnimation;

  const MainContentWidget({
    super.key,
    required this.scaleAnimation,
    required this.slideAnimation,
    required this.fadeAnimation,
    required this.portalAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: scaleAnimation.value,
                child: Container(
                  width: 200.w,
                  height: 200.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        ColorManager.portalGreen.withOpacity(0.1),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Lottie.asset(
                    'assets/lotties/rick.json',
                    fit: BoxFit.cover,
                    repeat: true,
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 40.h),
          AnimatedLogoWidget(
            slideAnimation: slideAnimation,
            fadeAnimation: fadeAnimation,
          ),
          SizedBox(height: 60.h),
          LoadingIndicatorWidget(portalAnimation: portalAnimation),
        ],
      ),
    );
  }
}