import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/core/theming/text_styles.dart';
import 'package:rick_and_morty/core/theming/color_manger.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_details_screen_widgets/favorite_fab.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_details_screen_widgets/details_section.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_details_screen_widgets/episodes_section.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_details_screen_widgets/character_info_card.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_details_screen_widgets/character_details_app_bar.dart';

class CharacterDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> character;

  const CharacterDetailsScreen({super.key, required this.character});

  @override
  State<CharacterDetailsScreen> createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen>
    with TickerProviderStateMixin {
  late AnimationController _heroController;
  late AnimationController _detailsController;
  late AnimationController _shimmerController;

  late Animation<double> _heroAnimation;
  late Animation<double> _detailsAnimation;
  late Animation<double> _shimmerAnimation;

  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _heroController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _detailsController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    _heroAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _heroController, curve: Curves.easeOutBack),
    );

    _detailsAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _detailsController, curve: Curves.easeOut),
    );

    _shimmerAnimation = Tween<double>(begin: -2.0, end: 2.0).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );

    _heroController.forward().then((_) {
      _detailsController.forward();
    });
  }

  @override
  void dispose() {
    _heroController.dispose();
    _detailsController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return ColorManager.portalGreen;
      case 'dead':
        return ColorManager.dangerRed;
      default:
        return ColorManager.asteroidGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(widget.character['status']);
    return Scaffold(
      backgroundColor: ColorManager.cosmicBlack,
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1.5,
            colors: [
              statusColor.withOpacity(0.1),
              ColorManager.cosmicBlack.withOpacity(0.8),
              ColorManager.cosmicBlack,
            ],
            stops: const [0.0, 0.4, 1.0],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            CharacterDetailsAppBar(
              character: widget.character,
              statusColor: statusColor,
              heroAnimation: _heroAnimation,
              shimmerAnimation: _shimmerAnimation,
              onBack: () => Navigator.pop(context),
            ),
            SliverToBoxAdapter(
              child: AnimatedBuilder(
                animation: _detailsAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, 50 * (1 - _detailsAnimation.value)),
                    child: Opacity(
                      opacity: _detailsAnimation.value,
                      child: child,
                    ),
                  );
                },
                child: Column(
                  children: [
                    CharacterInfoCard(
                      character: widget.character,
                      statusColor: statusColor,
                    ),
                    verticalSpace(24),
                    DetailsSection(
                      origin: widget.character['origin']['name'],
                      location: widget.character['location']['name'],
                    ),
                    verticalSpace(24),
                    EpisodesSection(
                      episodes: [
                        "Pilot",
                        "Lawnmower Dog",
                        "Anatomy Park",
                        "M. Night Shaym-Aliens!",
                        "Meeseeks and Destroy",
                      ],
                    ),
                    verticalSpace(100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FavoriteFAB(
        isFavorite: isFavorite,
        onPressed: () {
          setState(() {
            isFavorite = !isFavorite;
          });
        },
      ),
    );
  }
}
