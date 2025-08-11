import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/theming/color_manger.dart';

class PortalEffectWidget extends StatelessWidget {
  final Animation<double> portalAnimation;

  const PortalEffectWidget({super.key, required this.portalAnimation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: portalAnimation,
      builder: (context, child) {
        if (portalAnimation.value < 0.8) return const SizedBox.shrink();

        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.0 - (portalAnimation.value - 0.8) * 5,
              colors: [
                Colors.transparent,
                ColorManager.portalGreen.withOpacity(
                  (portalAnimation.value - 0.8) * 5 * 0.3,
                ),
                ColorManager.labWhite.withOpacity(
                  (portalAnimation.value - 0.8) * 5,
                ),
              ],
              stops: const [0.0, 0.8, 1.0],
            ),
          ),
        );
      },
    );
  }
}
