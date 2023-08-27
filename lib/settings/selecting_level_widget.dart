import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_game/logic/models.dart';
import 'package:tic_tac_game/settings/level_bloc/bloc_event.dart';
import 'package:tic_tac_game/settings/level_bloc/bloc_state.dart';

import 'level_bloc/settings_bloc.dart';

class SettingsLevelWidget extends StatelessWidget {
  const SettingsLevelWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsLevelBloc, LevelState>(
      buildWhen: (previous, current) => current.status.isSuccess,
      builder: (context, state) {
        return LevelSelectionWidget();
      },
    );
  }
}

class LevelSelectionWidget extends StatelessWidget {
  const LevelSelectionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsLevelBloc, LevelState>(
      builder: (context, state) {
        return Column(
          children: [
            Text(
              'Game Level',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              child: Text(
                'Easy',
                style: TextStyle(
                  color: state.selectedLevel == Level.easy
                      ? Colors.amber
                      : Colors.grey,
                  fontWeight: state.selectedLevel == Level.easy
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              onTap: () async {
                context.read<SettingsLevelBloc>().add(
                      SelectLevel(
                        level: Level.easy,
                      ),
                    );
              },
            ),
            GestureDetector(
              child: Text(
                'Middle',
                style: TextStyle(
                  color: state.selectedLevel == Level.middle
                      ? Colors.amber
                      : Colors.grey,
                  fontWeight: state.selectedLevel == Level.middle
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              onTap: () async {
                context.read<SettingsLevelBloc>().add(
                      SelectLevel(
                        level: Level.middle,
                      ),
                    );
              },
            ),
            GestureDetector(
              child: Text(
                'Hard',
                style: TextStyle(
                  color: state.selectedLevel == Level.hard
                      ? Colors.amber
                      : Colors.grey,
                  fontWeight: state.selectedLevel == Level.hard
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              onTap: () async {
                context.read<SettingsLevelBloc>().add(
                      SelectLevel(
                        level: Level.hard,
                      ),
                    );
              },
            ),
          ],
        );
      },
    );
  }
}
