import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/core/theming/color_manger.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';
// features/characters/presentation/widgets/character_details_screen_widgets/hero_image.dart

class HeroImage extends StatelessWidget {
  final Character character;
  final Color statusColor;
  final Animation<double> heroAnimation;

  const HeroImage({
    super.key,
    required this.character,
    required this.statusColor,
    required this.heroAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: heroAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: heroAnimation.value,
          child: Hero(
            tag: 'character_${character.id}',
            child: Container(
              width: 200.w,
              height: 200.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    statusColor.withOpacity(0.3),
                    statusColor.withOpacity(0.1),
                    Colors.transparent,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: statusColor.withOpacity(0.4),
                    blurRadius: 30,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: Container(
                margin: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(character.image),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    color: statusColor.withOpacity(0.6),
                    width: 3,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
