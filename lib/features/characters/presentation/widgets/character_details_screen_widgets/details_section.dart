import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/core/theming/text_styles.dart';
import 'package:rick_and_morty/core/theming/color_manger.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_details_screen_widgets/detail_card.dart';
// features/characters/presentation/widgets/character_details_screen_widgets/details_section.dart


class DetailsSection extends StatelessWidget {
  final String origin;
  final String location;

  const DetailsSection({
    super.key,
    required this.origin,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Details', style: TextStyles.whitePoppins24Medium),
          verticalSpace(16),
          DetailCard(
            title: 'Origin',
            value: origin,
            icon: Icons.home,
            color: ColorManager.portalGreen,
          ),
          verticalSpace(12),
          DetailCard(
            title: 'Last Known Location',
            value: location,
            icon: Icons.location_on,
            color: ColorManager.sciFiBlue,
          ),
        ],
      ),
    );
  }
}