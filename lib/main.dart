import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_game/wigets/game_settings_widget.dart';
import 'package:tic_tac_game/wigets/home_settings_widget.dart';
import 'package:tic_tac_game/wigets/home_widget.dart';

import 'wigets/game_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => HomeWidget(),
    ),
    GoRoute(
      name: 'home_settings',
      path: '/home_settings',
      builder: (context, state) => const HomeSettingsWidget(),
    ),
    GoRoute(
      name: 'game_settings',
      path: '/game_settings',
      builder: (context, state) => const GameSettingsWidget(),
    ),
    GoRoute(
      name: 'game',
      path: '/game',
      builder: (context, state) => const GameWidget(),
    ),
  ],
);
