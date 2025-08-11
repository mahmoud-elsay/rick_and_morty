import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/core/theming/color_manger.dart';

class PulsatingCirclesWidget extends StatelessWidget {
  final Animation<double> portalAnimation;

  const PulsatingCirclesWidget({
    super.key,
    required this.portalAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: portalAnimation,
      builder: (context, child) {
        return Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Transform.scale(
                scale: 1 + (portalAnimation.value * 2),
                child: Container(
                  width: 200.w,
                  height: 200.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: ColorManager.portalGreen.withOpacity(
                        0.3 * (1 - portalAnimation.value),
                      ),
                      width: 2,
                    ),
                  ),
                ),
              ),
              Transform.scale(
                scale: 1 + (portalAnimation.value * 1.5),
                child: Container(
                  width: 150.w,
                  height: 150.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: ColorManager.sciFiBlue.withOpacity(
                        0.4 * (1 - portalAnimation.value),
                      ),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}