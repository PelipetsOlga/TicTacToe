import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_game/logic/game_repository.dart';
import 'package:tic_tac_game/settings/game_with_comp_bloc/bloc_event.dart';
import 'package:tic_tac_game/settings/game_with_comp_bloc/settings_bloc.dart';
import 'package:tic_tac_game/settings/game_with_comp_level_widget.dart';
import 'package:tic_tac_game/settings/level_bloc/bloc_event.dart';
import 'package:tic_tac_game/settings/settings_level_widget.dart';

import 'level_bloc/settings_bloc.dart';

abstract class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: RepositoryProvider(
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
            ], child: SettingsLayout(getBackLink()))));
  }

  String getBackLink();
}

class SettingsLayout extends StatelessWidget {
  String backLink;

  SettingsLayout(this.backLink);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SettingsLevelWidget(),
            const SettingsGameWithCompWidget(),
            OutlinedButton(
                onPressed: () => context.go(backLink),
                child: const Text('Back')),
          ],
        ),
      ),
    );
  }
}
