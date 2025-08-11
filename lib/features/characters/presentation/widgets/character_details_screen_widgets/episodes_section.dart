import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/core/theming/text_styles.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_details_screen_widgets/episode_card.dart';
// features/characters/presentation/widgets/character_details_screen_widgets/episodes_section.dart

class EpisodesSection extends StatelessWidget {
  final List<String> episodes;

  const EpisodesSection({super.key, required this.episodes});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Episodes (${episodes.length})',
            style: TextStyles.whitePoppins24Medium,
          ),
          verticalSpace(16),
          ...episodes.asMap().entries.map((entry) {
            final index = entry.key;
            final episode = entry.value;
            return EpisodeCard(index: index, episode: episode);
          }).toList(),
        ],
      ),
    );
  }
}
