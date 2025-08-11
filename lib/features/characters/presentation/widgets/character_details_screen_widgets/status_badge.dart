import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/core/theming/text_styles.dart';
// features/characters/presentation/widgets/character_details_screen_widgets/status_badge.dart


class StatusBadge extends StatelessWidget {
  final String status;
  final Color statusColor;
  final Animation<double> heroAnimation;

  const StatusBadge({
    super.key,
    required this.status,
    required this.statusColor,
    required this.heroAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: heroAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: heroAnimation.value,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 8.h,
            ),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: statusColor.withOpacity(0.4),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Text(
              status.toUpperCase(),
              style: TextStyles.whitePoppins12Regular.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
        );
      },
    );
  }
}