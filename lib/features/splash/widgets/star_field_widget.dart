import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/core/theming/color_manger.dart';

class StarFieldWidget extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final Animation<double> portalAnimation;

  const StarFieldWidget({
    super.key,
    required this.fadeAnimation,
    required this.portalAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: fadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: fadeAnimation.value * 0.6,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: List.generate(50, (index) {
                return Positioned(
                  left: (index * 37.5) % MediaQuery.of(context).size.width,
                  top: (index * 23.7) % MediaQuery.of(context).size.height,
                  child: AnimatedBuilder(
                    animation: portalAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: 0.5 + (portalAnimation.value * 0.5),
                        child: Container(
                          width: 2.w,
                          height: 2.h,
                          decoration: BoxDecoration(
                            color: ColorManager.labWhite,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: ColorManager.portalGreen.withOpacity(0.3),
                                blurRadius: 4,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}