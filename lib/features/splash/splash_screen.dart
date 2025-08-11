import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/core/routes/routes_name.dart';
import 'package:rick_and_morty/core/helpers/extensions.dart';
import 'package:rick_and_morty/core/theming/color_manger.dart';
import 'package:rick_and_morty/features/splash/widgets/star_field_widget.dart';
import 'package:rick_and_morty/features/splash/widgets/main_content_widget.dart';
import 'package:rick_and_morty/features/splash/widgets/portal_effect_widget.dart';
import 'package:rick_and_morty/features/splash/widgets/pulsating_circles_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _slideController;
  late AnimationController _portalController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _portalAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _startAnimationSequence();
  }

  void _initAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );

    _portalController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _portalAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _portalController,
      curve: Curves.easeInOut,
    ));
  }

  void _startAnimationSequence() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _fadeController.forward();
    
    await Future.delayed(const Duration(milliseconds: 500));
    _scaleController.forward();
    
    await Future.delayed(const Duration(milliseconds: 800));
    _slideController.forward();
    
    await Future.delayed(const Duration(milliseconds: 1000));
    _portalController.forward();
    
    await Future.delayed(const Duration(milliseconds: 4500));
    _navigateToHome();
  }

  void _navigateToHome() {
    context.pushReplacementNamed(Routes.charactersScreen);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _slideController.dispose();
    _portalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.cosmicBlack,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.0,
            colors: [
              ColorManager.spaceshipDark.withOpacity(0.3),
              ColorManager.cosmicBlack,
              ColorManager.cosmicBlack,
            ],
            stops: const [0.0, 0.7, 1.0],
          ),
        ),
        child: Stack(
          children: [
            StarFieldWidget(fadeAnimation: _fadeAnimation, portalAnimation: _portalAnimation),
            PulsatingCirclesWidget(portalAnimation: _portalAnimation),
            MainContentWidget(
              scaleAnimation: _scaleAnimation,
              slideAnimation: _slideAnimation,
              fadeAnimation: _fadeAnimation,
              portalAnimation: _portalAnimation,
            ),
            PortalEffectWidget(portalAnimation: _portalAnimation),
          ],
        ),
      ),
    );
  }
}