
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_game/logic/models.dart';
import 'package:tic_tac_game/settings/who_first_bloc/bloc_event.dart';
import 'package:tic_tac_game/settings/who_first_bloc/bloc_state.dart';
import 'package:tic_tac_game/settings/who_first_bloc/settings_bloc.dart';


class SettingsWhoFirstWidget extends StatelessWidget {
  const SettingsWhoFirstWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsWhoFirstBloc, WhoFirstState>(
      buildWhen: (previous, current) => current.status.isSuccess,
      builder: (context, state) {
        return WhoFirstSelectionWidget();
      },
    );
  }
}

class WhoFirstSelectionWidget extends StatelessWidget {
  const WhoFirstSelectionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsWhoFirstBloc, WhoFirstState>(
      builder: (context, state) {
        return Column(
          children: [
            const Text(
              'Who\'s move is first',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              child: Text(
                'Me',
                style: TextStyle(
                  color: state.who == WhosTurnBeFirst.me
                      ? Colors.amber
                      : Colors.grey,
                  fontWeight: state.who == WhosTurnBeFirst.me
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              onTap: () async {
                context.read<SettingsWhoFirstBloc>().add(
                      SelectWhoFirst(
                        who: WhosTurnBeFirst.me,
                      ),
                    );
              },
            ),
            GestureDetector(
              child: Text(
                'opponent',
                style: TextStyle(
                  color: state.who == WhosTurnBeFirst.opponent
                      ? Colors.amber
                      : Colors.grey,
                  fontWeight: state.who == WhosTurnBeFirst.opponent
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              onTap: () async {
                context.read<SettingsWhoFirstBloc>().add(
                  SelectWhoFirst(
                    who: WhosTurnBeFirst.opponent,
                  ),
                );
              },
            ),
            GestureDetector(
              child: Text(
                'alternately',
                style: TextStyle(
                  color: state.who == WhosTurnBeFirst.alternately
                      ? Colors.amber
                      : Colors.grey,
                  fontWeight: state.who == WhosTurnBeFirst.alternately
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              onTap: () async {
                context.read<SettingsWhoFirstBloc>().add(
                  SelectWhoFirst(
                    who: WhosTurnBeFirst.alternately,
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
