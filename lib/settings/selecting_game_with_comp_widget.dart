import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'game_with_comp_bloc/bloc_event.dart';
import 'game_with_comp_bloc/bloc_state.dart';
import 'game_with_comp_bloc/settings_bloc.dart';

class SettingsGameWithCompWidget extends StatelessWidget {
  const SettingsGameWithCompWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsGameWithCompBloc, GameWithCompState>(
      buildWhen: (previous, current) => current.status.isSuccess,
      builder: (context, state) {
        return const GameWithCompSelectionWidget();
      },
    );
  }
}

class GameWithCompSelectionWidget extends StatelessWidget {
  const GameWithCompSelectionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsGameWithCompBloc, GameWithCompState>(
      builder: (context, state) {
        return Column(
          children: [
            const Text(
              'Game With Phone or with Friend',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              child: SvgPicture.asset(
                state.gameWithComp
                    ? 'assets/dog_with_phone.svg'
                    : 'assets/two_dogs.svg',
                semanticsLabel: 'Image',
              ),
              onTap: () async {
                context.read<SettingsGameWithCompBloc>().add(
                      SelectGameWithComp(gameWithComp: !state.gameWithComp),
                    );
              },
            ),
          ],
        );
      },
    );
  }
}
