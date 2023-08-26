import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tic_tac_game/routers.dart';

import 'logic/game_repository.dart';


GetIt getIt = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerSingleton<GameRepository>(GameRepositoryImpl(), signalsReady: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: routers,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

