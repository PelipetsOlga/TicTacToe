import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_game/settings/sound/bloc_event.dart';
import 'package:tic_tac_game/settings/sound/bloc_state.dart';
import 'package:tic_tac_game/settings/sound/settings_bloc.dart';

import 'game_with_comp_bloc/bloc_event.dart';
import 'game_with_comp_bloc/bloc_state.dart';
import 'game_with_comp_bloc/settings_bloc.dart';

class SettingsSoundWidget extends StatelessWidget {
  const SettingsSoundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsSoundBloc, SoundState>(
      buildWhen: (previous, current) => current.status.isSuccess,
      builder: (context, state) {
        return SoundSelectionWidget();
      },
    );
  }
}

class SoundSelectionWidget extends StatelessWidget {
  const SoundSelectionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsSoundBloc, SoundState>(
      builder: (context, state) {
        return Column(
          children: [
            const Text('Sound', style: TextStyle(fontWeight: FontWeight.bold)),
            GestureDetector(
              child: Text(
                'Sound ON',
                style: TextStyle(
                  color: state.turnedOn ? Colors.amber : Colors.grey,
                  fontWeight:
                      state.turnedOn ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              onTap: () async {
                context.read<SettingsSoundBloc>().add(
                      SelectSound(turnedOn: true),
                    );
              },
            ),
            GestureDetector(
              child: Text(
                'Sound OFF',
                style: TextStyle(
                  color: !state.turnedOn ? Colors.amber : Colors.grey,
                  fontWeight:
                      !state.turnedOn ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              onTap: () async {
                context.read<SettingsSoundBloc>().add(
                      SelectSound(turnedOn: false),
                    );
              },
            ),
          ],
        );
      },
    );
  }
}
