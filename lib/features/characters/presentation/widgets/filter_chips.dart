import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/core/theming/text_styles.dart';
import 'package:rick_and_morty/core/theming/color_manger.dart';

class FilterChipsWidget extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterSelected;
  final Animation<double> filterAnimation;

  const FilterChipsWidget({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
    required this.filterAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final filters = [
      {'label': 'All', 'icon': Icons.grid_view},
      {'label': 'Alive', 'icon': Icons.favorite},
      {'label': 'Dead', 'icon': Icons.dangerous},
      {'label': 'unknown', 'icon': Icons.help_outline},
    ];

    return Container(
      height: 50.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (context, index) => horizontalSpace(12),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = filter['label'] == selectedFilter;

          return AnimatedBuilder(
            animation: filterAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: isSelected ? (1.0 + filterAnimation.value * 0.1) : 1.0,
                child: GestureDetector(
                  onTap: () => onFilterSelected(filter['label'] as String),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? LinearGradient(
                              colors: [
                                ColorManager.portalGreen.withOpacity(0.3),
                                ColorManager.sciFiBlue.withOpacity(0.2),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : LinearGradient(
                              colors: [
                                ColorManager.spaceshipDark.withOpacity(0.6),
                                ColorManager.spaceshipDark.withOpacity(0.4),
                              ],
                            ),
                      borderRadius: BorderRadius.circular(25.r),
                      border: Border.all(
                        color: isSelected
                            ? ColorManager.portalGreen.withOpacity(0.6)
                            : ColorManager.asteroidGrey.withOpacity(0.3),
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: ColorManager.portalGreen.withOpacity(
                                  0.2,
                                ),
                                blurRadius: 12,
                                spreadRadius: 2,
                              ),
                            ]
                          : [
                              BoxShadow(
                                color: ColorManager.cosmicBlack.withOpacity(
                                  0.3,
                                ),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          filter['icon'] as IconData,
                          color: isSelected
                              ? ColorManager.portalGreen
                              : ColorManager.labWhite.withOpacity(0.7),
                          size: 18.sp,
                        ),
                        horizontalSpace(8),
                        Text(
                          filter['label'] as String,
                          style: TextStyles.whitePoppins12Regular.copyWith(
                            color: isSelected
                                ? ColorManager.portalGreen
                                : ColorManager.labWhite.withOpacity(0.8),
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
