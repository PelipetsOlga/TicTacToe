import 'package:go_router/go_router.dart';
import 'package:tic_tac_game/settings/settings_widget.dart';
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
      name: 'settings',
      path: '/settings',
      builder: (context, state) => const SettingsWidget(),
    ),
    GoRoute(
      name: 'game',
      path: '/game',
      builder: (context, state) => const GameWidget(),
    ),
  ],
);
