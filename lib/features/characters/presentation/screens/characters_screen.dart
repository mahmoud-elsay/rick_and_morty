import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/core/helpers/debouncer.dart';
import 'package:rick_and_morty/core/helpers/extensions.dart';
import 'package:rick_and_morty/core/routes/routes_name.dart';
import 'package:rick_and_morty/core/theming/text_styles.dart';
import 'package:rick_and_morty/core/theming/color_manger.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';
import 'package:rick_and_morty/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:rick_and_morty/features/characters/presentation/bloc/characters_event.dart';
import 'package:rick_and_morty/features/characters/presentation/bloc/characters_state.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_screen_widgets/search_bar.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_screen_widgets/filter_chips.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_screen_widgets/offline_banner.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_screen_widgets/character_grid.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late Debouncer _debouncer;
  late AnimationController _filterAnimationController;
  late Animation<double> _filterAnimation;

  @override
  void initState() {
    super.initState();
    _debouncer = Debouncer(milliseconds: 400);
    _filterAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _filterAnimation = CurvedAnimation(
      parent: _filterAnimationController,
      curve: Curves.easeInOut,
    );
    _setupScrollListener();
    // Load initial data
    context.read<CharactersBloc>().add(const LoadCharacters());
    _filterAnimationController.forward();
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        final state = context.read<CharactersBloc>().state;
        if (state is CharactersLoaded &&
            !state.isLoadingMore &&
            !state.hasReachedMax) {
          context.read<CharactersBloc>().add(const LoadMoreCharacters());
        }
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _debouncer.dispose();
    _filterAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.cosmicBlack,
      body: BlocConsumer<CharactersBloc, CharactersState>(
        listener: (context, state) {
          if (state is CharactersError && state.cachedCharacters.isEmpty) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: ColorManager.dangerRed,
                ),
              );
            }
          }
        },
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorManager.cosmicBlack,
                  ColorManager.spaceshipDark.withOpacity(0.8),
                  ColorManager.cosmicBlack,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  if (state is CharactersLoaded && !state.isOnline)
                    const OfflineBanner(),
                  _buildAppBar(state),
                  verticalSpace(16),
                  SearchBarWidget(
                    controller: _searchController,
                    onChanged: (query) {
                      _debouncer.run(() {
                        if (mounted) {
                          context.read<CharactersBloc>().add(
                            SearchCharacters(query),
                          );
                        }
                      });
                    },
                  ),
                  verticalSpace(16),
                  if (state is CharactersLoaded)
                    FilterChipsWidget(
                      selectedFilter: state.currentFilter,
                      onFilterSelected: (filter) {
                        if (mounted) {
                          context.read<CharactersBloc>().add(
                            FilterCharacters(filter),
                          );
                        }
                      },
                      filterAnimation: _filterAnimation,
                    ),
                  verticalSpace(20),
                  _buildCharacterGrid(state),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppBar(CharactersState state) {
    final characterCount = state is CharactersLoaded
        ? state.characters.length
        : 0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorManager.spaceshipDark.withOpacity(0.1),
            Colors.transparent,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [ColorManager.portalGreen, ColorManager.sciFiBlue],
                  ).createShader(bounds),
                  child: Text(
                    'Rick & Morty',
                    style: TextStyles.whitePoppins24Medium,
                  ),
                ),
                Text(
                  '$characterCount Characters',
                  style: TextStyles.whitePoppins12Regular.copyWith(
                    color: ColorManager.labWhite.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              if (state is CharactersLoaded && mounted) {
                _navigateToFavorites(state.favoriteIds, state.characters);
              }
            },
            child: Hero(
              tag: 'favorites_button',
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ColorManager.portalGreen.withOpacity(0.2),
                      ColorManager.sciFiBlue.withOpacity(0.1),
                    ],
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorManager.portalGreen.withOpacity(0.4),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.portalGreen.withOpacity(0.3),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: ColorManager.portalGreen,
                      size: 24.sp,
                    ),
                    if (state is CharactersLoaded &&
                        state.favoriteIds.isNotEmpty)
                      Positioned(
                        right: -2,
                        top: -2,
                        child: Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: ColorManager.dangerRed,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${state.favoriteIds.length}',
                            style: TextStyles.whitePoppins12Regular.copyWith(
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCharacterGrid(CharactersState state) {
    if (state is CharactersLoading) {
      return const Expanded(child: _InitialGridShimmer());
    }

    if (state is CharactersError) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, size: 48.sp, color: ColorManager.dangerRed),
              verticalSpace(16),
              Text(state.message, style: TextStyles.whitePoppins15Medium),
              if (state.cachedCharacters.isNotEmpty) ...[
                verticalSpace(16),
                Text(
                  'Showing cached data',
                  style: TextStyles.whitePoppins12Regular,
                ),
              ],
              verticalSpace(16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.portalGreen,
                  foregroundColor: ColorManager.labWhite,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 12.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 4,
                ),
                onPressed: () {
                  if (mounted) {
                    context.read<CharactersBloc>().add(
                      const LoadCharacters(isRefresh: true),
                    );
                  }
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (state is CharactersLoaded) {
      if (state.characters.isEmpty) {
        return Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off,
                  size: 48.sp,
                  color: ColorManager.asteroidGrey,
                ),
                verticalSpace(16),
                Text(
                  'No characters found',
                  style: TextStyles.whitePoppins18Medium.copyWith(
                    color: ColorManager.labWhite,
                  ),
                ),
                verticalSpace(8),
                Text(
                  'Try adjusting your search or filter',
                  style: TextStyles.whitePoppins14Regular.copyWith(
                    color: ColorManager.asteroidGrey,
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return Expanded(
        child: CharacterGridWidget(
          characters: state.characters,
          favoriteCharacterIds: state.favoriteIds,
          scrollController: _scrollController,
          onToggleFavorite: (characterId) {
            if (mounted) {
              context.read<CharactersBloc>().add(ToggleFavorite(characterId));
            }
          },
          onCharacterTap: (character) {
            if (mounted) {
              _navigateToDetails(character);
            }
          },
          isLoadingMore: state.isLoadingMore,
        ),
      );
    }

    return const Expanded(child: _InitialGridShimmer());
  }

  void _navigateToDetails(Character character) async {
    if (!mounted) return;

    try {
      await context.pushNamed(
        Routes.characterDetailsScreen,
        arguments: character,
      );
      // No need to handle result since BLoC manages state
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error navigating to details: $e'),
            backgroundColor: ColorManager.dangerRed,
          ),
        );
      }
    }
  }

  void _navigateToFavorites(
    Set<int> favoriteIds,
    List<Character> allCharacters,
  ) async {
    if (!mounted) return;

    try {
      final favoritesToSend = allCharacters
          .where((c) => favoriteIds.contains(c.id))
          .toList();

      await context.pushNamed(
        Routes.favoritesScreen,
        arguments: favoritesToSend,
      );
      // No need to handle result since BLoC manages state
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error navigating to favorites: $e'),
            backgroundColor: ColorManager.dangerRed,
          ),
        );
      }
    }
  }
}

class _InitialGridShimmer extends StatelessWidget {
  const _InitialGridShimmer();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = 2;
        final itemWidth = (constraints.maxWidth - 20.w * 2 - 16.w) / 2;
        final itemHeight = itemWidth / 0.75;
        final rows = (constraints.maxHeight / (itemHeight + 16.h)).ceil();

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 0.75,
            ),
            itemCount: crossAxisCount * rows,
            itemBuilder: (context, index) {
              return const _ShimmerCard();
            },
          ),
        );
      },
    );
  }
}

class _ShimmerCard extends StatefulWidget {
  const _ShimmerCard();

  @override
  State<_ShimmerCard> createState() => _ShimmerCardState();
}

class _ShimmerCardState extends State<_ShimmerCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.spaceshipDark.withOpacity(0.25),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: ColorManager.asteroidGrey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Column(
          children: [
            Expanded(flex: 3, child: _ShimmerBlock(controller: _controller)),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ShimmerLine(
                      height: 14.h,
                      width: 120.w,
                      controller: _controller,
                    ),
                    SizedBox(height: 8.h),
                    _ShimmerLine(
                      height: 10.h,
                      width: 160.w,
                      controller: _controller,
                    ),
                    SizedBox(height: 12.h),
                    _ShimmerLine(
                      height: 12.h,
                      width: double.infinity,
                      controller: _controller,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShimmerBlock extends StatelessWidget {
  final AnimationController controller;
  const _ShimmerBlock({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1 + controller.value * 2, -1),
              end: Alignment(1 + controller.value * 2, 1),
              colors: [
                ColorManager.spaceshipDark.withOpacity(0.2),
                ColorManager.portalGreen.withOpacity(0.08),
                ColorManager.spaceshipDark.withOpacity(0.2),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ShimmerLine extends StatelessWidget {
  final double height;
  final double width;
  final AnimationController controller;

  const _ShimmerLine({
    required this.height,
    required this.width,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: _ShimmerBlock(controller: controller),
    );
  }
}
