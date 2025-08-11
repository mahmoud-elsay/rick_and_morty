import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/core/routes/routes_name.dart';
import 'package:rick_and_morty/core/helpers/extensions.dart';
import 'package:rick_and_morty/core/theming/text_styles.dart';
import 'package:rick_and_morty/core/theming/color_manger.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_screen_widgets/search_bar.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_screen_widgets/filter_chips.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_screen_widgets/character_grid.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_screen_widgets/offline_banner.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late AnimationController _filterAnimationController;
  late Animation<double> _filterAnimation;

  String selectedFilter = 'All';
  bool isOffline = false;
  List<Map<String, dynamic>> allCharacters = [];
  List<Map<String, dynamic>> filteredCharacters = [];
  Set<int> favoriteCharacterIds = {};

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _loadStaticData();
    _setupScrollListener();
  }

  void _initAnimations() {
    _filterAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _filterAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _filterAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _loadStaticData() {
    allCharacters = [
      {
        "id": 1,
        "name": "Rick Sanchez",
        "status": "Alive",
        "species": "Human",
        "gender": "Male",
        "origin": {"name": "Earth (C-137)"},
        "location": {"name": "Citadel of Ricks"},
        "image": "assets/images/rick.jpeg",
      },
      {
        "id": 2,
        "name": "Morty Smith",
        "status": "Alive",
        "species": "Human",
        "gender": "Male",
        "origin": {"name": "unknown"},
        "location": {"name": "Citadel of Ricks"},
        "image": "assets/images/rick.jpeg",
      },
      {
        "id": 3,
        "name": "Summer Smith",
        "status": "Alive",
        "species": "Human",
        "gender": "Female",
        "origin": {"name": "Earth (Replacement Dimension)"},
        "location": {"name": "Earth (Replacement Dimension)"},
        "image": "assets/images/rick.png",
      },
      {
        "id": 4,
        "name": "Beth Smith",
        "status": "Alive",
        "species": "Human",
        "gender": "Female",
        "origin": {"name": "Earth (Replacement Dimension)"},
        "location": {"name": "Earth (Replacement Dimension)"},
        "image": "assets/images/rick.png",
      },
      {
        "id": 5,
        "name": "Jerry Smith",
        "status": "Alive",
        "species": "Human",
        "gender": "Male",
        "origin": {"name": "Earth (Replacement Dimension)"},
        "location": {"name": "Earth (Replacement Dimension)"},
        "image": "assets/images/rick.png",
      },
      {
        "id": 6,
        "name": "Abadango Cluster Princess",
        "status": "Alive",
        "species": "Alien",
        "gender": "Female",
        "origin": {"name": "Abadango"},
        "location": {"name": "Abadango"},
        "image": "assets/images/rick.png",
      },
      {
        "id": 7,
        "name": "Abradolf Lincler",
        "status": "unknown",
        "species": "Human",
        "gender": "Male",
        "origin": {"name": "Earth (Replacement Dimension)"},
        "location": {"name": "Testicle Monster Dimension"},
        "image": "assets/images/rick.png",
      },
      {
        "id": 8,
        "name": "Adjudicator Rick",
        "status": "Dead",
        "species": "Human",
        "gender": "Male",
        "origin": {"name": "unknown"},
        "location": {"name": "Citadel of Ricks"},
        "image": "assets/images/rick.png",
      },
    ];

    _applyFilters();
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _loadMoreCharacters();
      }
    });
  }

  void _loadMoreCharacters() {}

  void _applyFilters() {
    List<Map<String, dynamic>> tempList = List.from(allCharacters);

    if (selectedFilter != 'All') {
      tempList = tempList
          .where(
            (character) =>
                character['status'].toString().toLowerCase() ==
                selectedFilter.toLowerCase(),
          )
          .toList();
    }

    if (_searchController.text.isNotEmpty) {
      tempList = tempList
          .where(
            (character) => character['name'].toString().toLowerCase().contains(
              _searchController.text.toLowerCase(),
            ),
          )
          .toList();
    }

    setState(() {
      filteredCharacters = tempList;
    });
  }

  void _onFilterSelected(String filter) {
    setState(() {
      selectedFilter = filter;
    });
    _filterAnimationController.forward().then((_) {
      _filterAnimationController.reverse();
    });
    _applyFilters();
  }

  void _onSearchChanged(String query) {
    Future.delayed(const Duration(milliseconds: 300), () {
      _applyFilters();
    });
  }

  void _toggleFavorite(int characterId) {
    setState(() {
      if (favoriteCharacterIds.contains(characterId)) {
        favoriteCharacterIds.remove(characterId);
      } else {
        favoriteCharacterIds.add(characterId);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _filterAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.cosmicBlack,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
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
              if (isOffline) const OfflineBanner(),
              _buildAppBar(),
              verticalSpace(16),
              SearchBarWidget(
                controller: _searchController,
                onChanged: _onSearchChanged,
              ),
              verticalSpace(16),
              FilterChipsWidget(
                selectedFilter: selectedFilter,
                onFilterSelected: _onFilterSelected,
                filterAnimation: _filterAnimation,
              ),
              verticalSpace(20),
              Expanded(
                child: CharacterGridWidget(
                  characters: filteredCharacters,
                  favoriteCharacterIds: favoriteCharacterIds,
                  scrollController: _scrollController,
                  onToggleFavorite: _toggleFavorite,
                  onCharacterTap: (character) => _navigateToDetails(character),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
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
                    style: TextStyles.whitePoppins24Medium.copyWith(
                      color: ColorManager.labWhite,
                    ),
                  ),
                ),
                Text(
                  '${filteredCharacters.length} Characters',
                  style: TextStyles.whitePoppins12Regular.copyWith(
                    color: ColorManager.labWhite.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => context.pushNamed(Routes.favoritesScreen),
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
                    if (favoriteCharacterIds.isNotEmpty)
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
                            '${favoriteCharacterIds.length}',
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

  void _navigateToDetails(Map<String, dynamic> character) {
    context.pushNamed(Routes.characterDetailsScreen, arguments: character);
  }
}
