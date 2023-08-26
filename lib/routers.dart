import 'package:go_router/go_router.dart';
import 'package:tic_tac_game/settings/game_settings_widget.dart';
import 'package:tic_tac_game/settings/home_settings_widget.dart';
import 'package:tic_tac_game/wigets/home_widget.dart';

import 'game/game_widget.dart';

final routers = GoRouter(
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


