import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/core/theming/text_styles.dart';
import 'package:rick_and_morty/core/theming/color_manger.dart';

class SearchBarWidget extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                gradient: LinearGradient(
                  colors: [
                    ColorManager.spaceshipDark.withOpacity(0.9),
                    ColorManager.spaceshipDark.withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: _isFocused
                      ? ColorManager.portalGreen.withOpacity(0.5)
                      : ColorManager.asteroidGrey.withOpacity(0.2),
                  width: _isFocused ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _isFocused
                        ? ColorManager.portalGreen.withOpacity(0.1)
                        : ColorManager.cosmicBlack.withOpacity(0.3),
                    blurRadius: _isFocused ? 12 : 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: widget.controller,
                style: TextStyles.whitePoppins15Medium,
                decoration: InputDecoration(
                  hintText: 'Search characters across dimensions...',
                  hintStyle: TextStyles.whitePoppins15Light.copyWith(
                    color: ColorManager.asteroidGrey,
                  ),
                  prefixIcon: Container(
                    padding: EdgeInsets.all(12.w),
                    child: ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          ColorManager.portalGreen,
                          ColorManager.sciFiBlue,
                        ],
                      ).createShader(bounds),
                      child: Icon(
                        Icons.search,
                        color: ColorManager.portalGreen,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  suffixIcon: widget.controller.text.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            widget.controller.clear();
                            widget.onChanged('');
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(12.w),
                            child: Icon(
                              Icons.clear,
                              color: ColorManager.asteroidGrey,
                              size: 18.sp,
                            ),
                          ),
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 18.h,
                    horizontal: 16.w,
                  ),
                ),
                onChanged: (value) {
                  widget.onChanged(value);
                  setState(() {});
                },
                onTap: () {
                  setState(() => _isFocused = true);
                  _animationController.forward();
                },
                onEditingComplete: () {
                  setState(() => _isFocused = false);
                  _animationController.reverse();
                },
                onSubmitted: (_) {
                  setState(() => _isFocused = false);
                  _animationController.reverse();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
