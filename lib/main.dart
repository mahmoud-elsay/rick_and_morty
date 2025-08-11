import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_and_morty/bloc_observer.dart';
import 'package:rick_and_morty/rick_and_morty_app.dart';
import 'package:rick_and_morty/core/di/dependency_injection.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await setupGetIt();
  runApp(const RickAndMortyApp());
}
