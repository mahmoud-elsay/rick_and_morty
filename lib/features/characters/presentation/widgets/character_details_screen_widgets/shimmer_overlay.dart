import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/theming/color_manger.dart';
// features/characters/presentation/widgets/character_details_screen_widgets/shimmer_overlay.dart


class ShimmerOverlay extends StatelessWidget {
  final Animation<double> shimmerAnimation;

  const ShimmerOverlay({
    super.key,
    required this.shimmerAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: shimmerAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.transparent,
                ColorManager.portalGreen.withOpacity(0.1),
                Colors.transparent,
              ],
              stops: [
                shimmerAnimation.value - 0.3,
                shimmerAnimation.value,
                shimmerAnimation.value + 0.3,
              ],
            ),
          ),
        );
      },
    );
  }
}