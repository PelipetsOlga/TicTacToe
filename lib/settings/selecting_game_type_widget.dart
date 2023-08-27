import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_game/logic/models.dart';
import 'package:tic_tac_game/settings/game_type_bloc/bloc_event.dart';

import 'game_type_bloc/bloc_state.dart';
import 'game_type_bloc/settings_bloc.dart';

class SettingsGameTypeWidget extends StatelessWidget {
  const SettingsGameTypeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsGameTypeBloc, GameTypeState>(
      buildWhen: (previous, current) => current.status.isSuccess,
      builder: (context, state) {
        return GameTypeSelectionWidget();
      },
    );
  }
}

class GameTypeSelectionWidget extends StatelessWidget {
  GameTypeSelectionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsGameTypeBloc, GameTypeState>(
        builder: (context, state) {
      return Column(children: [
        const Text('Game Type', style: TextStyle(fontWeight: FontWeight.bold)),
        Column(
          children: GameType.values.map((type) {
            return getTypeItem(
              context,
              type,
              type.name,
              state,
              () async {
                context
                    .read<SettingsGameTypeBloc>()
                    .add(SelectGameType(gameType: type));
              },
            );
          }).toList(),
        ),
      ]);
    });
  }

  Widget getTypeItem(BuildContext context, GameType type, String typeName,
      GameTypeState state, VoidCallback callback) {
    return GestureDetector(
      onTap: callback,
      child: Text(
        typeName,
        style: TextStyle(
          color: state.selectedGameType == type ? Colors.amber : Colors.grey,
          fontWeight: state.selectedGameType == type
              ? FontWeight.bold
              : FontWeight.normal,
        ),
      ),
    );
  }
}
