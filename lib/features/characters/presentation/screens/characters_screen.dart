import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/helpers/spacing.dart';
import 'package:rick_and_morty/core/routes/routes_name.dart';
import 'package:rick_and_morty/core/theming/text_styles.dart';
import 'package:rick_and_morty/core/theming/color_manger.dart';
import 'package:rick_and_morty/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:rick_and_morty/features/characters/presentation/bloc/characters_event.dart';
import 'package:rick_and_morty/features/characters/presentation/bloc/characters_state.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_screen_widgets/search_bar.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_screen_widgets/filter_chips.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_screen_widgets/offline_banner.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _debouncer = Debouncer(milliseconds: 400);
    _setupScrollListener();
    // Load initial data
    context.read<CharactersBloc>().add(const LoadCharacters());
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<CharactersBloc>().add(const LoadMoreCharacters());
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.cosmicBlack,
      body: BlocConsumer<CharactersBloc, CharactersState>(
        listener: (context, state) {
          // Handle any side effects (like showing error messages)
          if (state is CharactersError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
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
                        context.read<CharactersBloc>().add(
                          SearchCharacters(query),
                        );
                      });
                    },
                  ),
                  verticalSpace(16),
                  if (state is CharactersLoaded)
                    FilterChipsWidget(
                      selectedFilter: state.currentFilter,
                      onFilterSelected: (filter) {
                        context.read<CharactersBloc>().add(
                          FilterCharacters(filter),
                        );
                      },
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
              if (state is CharactersLoaded) {
                _navigateToFavorites(state.favoriteIds);
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
      return const Expanded(child: Center(child: CircularProgressIndicator()));
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
            ],
          ),
        ),
      );
    }

    if (state is CharactersLoaded) {
      return Expanded(
        child: CharacterGridWidget(
          characters: state.characters,
          favoriteCharacterIds: state.favoriteIds,
          scrollController: _scrollController,
          onToggleFavorite: (characterId) {
            context.read<CharactersBloc>().add(ToggleFavorite(characterId));
          },
          onCharacterTap: (character) {
            _navigateToDetails(character);
          },
          isLoadingMore: state.isLoadingMore,
        ),
      );
    }

    return const Expanded(child: Center(child: CircularProgressIndicator()));
  }

  void _navigateToDetails(Map<String, dynamic> character) async {
    final result =
        await context.pushNamed(
              Routes.characterDetailsScreen,
              arguments: character,
            )
            as Map<String, dynamic>?;

    if (result != null &&
        result.containsKey('id') &&
        result.containsKey('isFavorite')) {
      context.read<CharactersBloc>().add(ToggleFavorite(result['id'] as int));
    }
  }

  void _navigateToFavorites(Set<int> favoriteIds) async {
    final result =
        await context.pushNamed(Routes.favoritesScreen, arguments: favoriteIds)
            as Map<String, dynamic>?;

    if (result != null && result.containsKey('id')) {
      context.read<CharactersBloc>().add(ToggleFavorite(result['id'] as int));
    }
  }
}
