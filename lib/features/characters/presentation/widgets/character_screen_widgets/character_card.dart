import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/core/theming/text_styles.dart';
import 'package:rick_and_morty/core/theming/color_manger.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';

class CharacterCard extends StatefulWidget {
  final Character character;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;
  final VoidCallback onTap;

  const CharacterCard({
    super.key,
    required this.character,
    required this.isFavorite,
    required this.onToggleFavorite,
    required this.onTap,
  });

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard>
    with TickerProviderStateMixin {
  late AnimationController _hoverController;
  late AnimationController _favoriteController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _favoriteAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _favoriteController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );

    _favoriteAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _favoriteController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _favoriteController.dispose();
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
    return GestureDetector(
      onTap: () {
        _hoverController.forward().then((_) {
          _hoverController.reverse();
        });
        widget.onTap();
      },
      onTapDown: (_) => setState(() => _isHovered = true),
      onTapUp: (_) => setState(() => _isHovered = false),
      onTapCancel: () => setState(() => _isHovered = false),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _isHovered ? _scaleAnimation.value : 1.0,
            child: Hero(
              tag: 'character_${widget.character.id}',
              child: Container(
                constraints: BoxConstraints(minHeight: 100.h, maxHeight: 220.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ColorManager.spaceshipDark.withOpacity(0.9),
                      ColorManager.spaceshipDark.withOpacity(0.7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: _getStatusColor(
                      widget.character.status,
                    ).withOpacity(0.3),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _getStatusColor(
                        widget.character.status,
                      ).withOpacity(0.1),
                      blurRadius: 12,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                    BoxShadow(
                      color: ColorManager.cosmicBlack.withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCharacterImage(constraints.maxHeight * 0.6),
                          _buildCharacterInfo(constraints.maxHeight * 0.4),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCharacterImage(double height) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _getStatusColor(widget.character.status).withOpacity(0.1),
              ColorManager.spaceshipDark.withOpacity(0.3),
            ],
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
              child: CachedNetworkImage(
                imageUrl: widget.character.image,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.portalGreen,
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey,
                  child: Icon(Icons.person, size: 48.sp),
                ),
              ),
            ),
            Positioned(
              top: 8.h,
              right: 8.w,
              child: GestureDetector(
                onTap: () {
                  widget.onToggleFavorite();
                  _favoriteController.forward().then((_) {
                    _favoriteController.reverse();
                  });
                },
                child: AnimatedBuilder(
                  animation: _favoriteAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _favoriteAnimation.value,
                      child: Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(
                          color: ColorManager.cosmicBlack.withOpacity(0.7),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: widget.isFavorite
                                ? ColorManager.portalGreen.withOpacity(0.6)
                                : ColorManager.asteroidGrey.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          widget.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: widget.isFavorite
                              ? ColorManager.portalGreen
                              : ColorManager.asteroidGrey,
                          size: 16.sp,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: 8.h,
              left: 8.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _getStatusColor(
                    widget.character.status,
                  ).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  widget.character.status,
                  style: TextStyles.whitePoppins12Regular.copyWith(
                    fontSize: 10.sp,
                    color: ColorManager.labWhite,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCharacterInfo(double height) {
    return SizedBox(
      height: height,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.character.name,
                  style: TextStyles.whitePoppins15Medium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                verticalSpace(4),
                Row(
                  children: [
                    Container(
                      width: 6.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                        color: _getStatusColor(widget.character.status),
                        shape: BoxShape.circle,
                      ),
                    ),
                    horizontalSpace(6),
                    Expanded(
                      child: Text(
                        '${widget.character.species} • ${widget.character.gender}',
                        style: TextStyles.whitePoppins12Regular.copyWith(
                          color: ColorManager.labWhite.withOpacity(0.7),
                          fontSize: 11.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorManager.sciFiBlue.withOpacity(0.2),
                    ColorManager.portalGreen.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: ColorManager.sciFiBlue.withOpacity(0.3),
                  width: 0.5,
                ),
              ),
              child: Text(
                widget.character.location.name,
                style: TextStyles.whitePoppins12Regular.copyWith(
                  color: ColorManager.sciFiBlue,
                  fontSize: 10.sp,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
