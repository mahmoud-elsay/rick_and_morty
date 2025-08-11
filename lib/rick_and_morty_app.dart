import 'core/routes/app_router.dart';
import 'core/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'core/theming/color_manger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/di/dependency_injection.dart';
import 'package:rick_and_morty/features/characters/presentation/bloc/characters_bloc.dart';

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => BlocProvider(
        create: (_) => getIt<CharactersBloc>(),
        child: MaterialApp(
          title: 'Rick and Morty',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: ColorManager.spaceshipDark,
            primaryColor: ColorManager.portalGreen,
          ),
          initialRoute: Routes.splashScreen,
          onGenerateRoute: AppRouter().generateRoute,
        ),
      ),
    );
  }
}
