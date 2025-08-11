import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/core/theming/text_styles.dart';
import 'package:rick_and_morty/core/theming/color_manger.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_details_screen_widgets/info_chip.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';
// features/characters/presentation/widgets/character_details_screen_widgets/character_info_card.dart

class CharacterInfoCard extends StatelessWidget {
  final Character character;
  final Color statusColor;

  const CharacterInfoCard({
    super.key,
    required this.character,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorManager.spaceshipDark.withOpacity(0.9),
            ColorManager.spaceshipDark.withOpacity(0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: statusColor.withOpacity(0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: statusColor.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [statusColor, ColorManager.sciFiBlue],
            ).createShader(bounds),
            child: Text(
              character.name,
              style: TextStyles.whitePoppins32Medium.copyWith(
                color: ColorManager.labWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          verticalSpace(16),
          Row(
            children: [
              InfoChip(
                icon: Icons.wb_sunny,
                label: character.species,
                color: ColorManager.portalGreen,
              ),
              horizontalSpace(12),
              InfoChip(
                icon: character.gender == 'Male' ? Icons.male : Icons.female,
                label: character.gender,
                color: ColorManager.sciFiBlue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
