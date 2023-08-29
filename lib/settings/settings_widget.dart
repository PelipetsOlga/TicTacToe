import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_game/logic/game_repository.dart';
import 'package:tic_tac_game/settings/game_type_bloc/bloc_event.dart';
import 'package:tic_tac_game/settings/game_with_comp_bloc/bloc_event.dart';
import 'package:tic_tac_game/settings/game_with_comp_bloc/settings_bloc.dart';
import 'package:tic_tac_game/settings/selecting_game_type_widget.dart';
import 'package:tic_tac_game/settings/selecting_game_with_comp_widget.dart';
import 'package:tic_tac_game/settings/level_bloc/bloc_event.dart';
import 'package:tic_tac_game/settings/selecting_level_widget.dart';
import 'package:tic_tac_game/settings/selecting_sound_widget.dart';
import 'package:tic_tac_game/settings/selecting_who_first_widget.dart';
import 'package:tic_tac_game/settings/sound/bloc_event.dart';
import 'package:tic_tac_game/settings/sound/settings_bloc.dart';
import 'package:tic_tac_game/settings/who_first_bloc/bloc_event.dart';
import 'package:tic_tac_game/settings/who_first_bloc/settings_bloc.dart';

import 'game_type_bloc/settings_bloc.dart';
import 'level_bloc/settings_bloc.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Screen'),
        automaticallyImplyLeading: false,
      ),
      body: RepositoryProvider(
          create: (context) => GetIt.instance.get<GameRepository>(),
          child: MultiBlocProvider(providers: [
            BlocProvider<SettingsLevelBloc>(
              create: (context) => SettingsLevelBloc(
                gameRepository: context.read<GameRepository>(),
              )..add(
                  GetLevel(),
                ),
            ),
            BlocProvider<SettingsGameWithCompBloc>(
              create: (context) => SettingsGameWithCompBloc(
                gameRepository: context.read<GameRepository>(),
              )..add(
                  GetGameWithComp(),
                ),
            ),
            BlocProvider<SettingsGameTypeBloc>(
              create: (context) => SettingsGameTypeBloc(
                gameRepository: context.read<GameRepository>(),
              )..add(
                  GetGameType(),
                ),
            ),
            BlocProvider<SettingsWhoFirstBloc>(
              create: (context) => SettingsWhoFirstBloc(
                gameRepository: context.read<GameRepository>(),
              )..add(
                  GetWhoFirst(),
                ),
            ),
            BlocProvider<SettingsSoundBloc>(
              create: (context) => SettingsSoundBloc(
                gameRepository: context.read<GameRepository>(),
              )..add(
                  GetSound(),
                ),
            ),
          ], child: const SettingsLayout())),
    );
  }
}

class SettingsLayout extends StatelessWidget {
  const SettingsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SettingsLevelWidget(),
            const SettingsGameWithCompWidget(),
            const SettingsGameTypeWidget(),
            const SettingsWhoFirstWidget(),
            const SettingsSoundWidget(),
            OutlinedButton(
                onPressed: () => context.pop(), child: const Text('Back')),
          ],
        ),
      ),
    );
  }
}
