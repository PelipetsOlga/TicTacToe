import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_game/game/bloc/bloc_state.dart';
import 'package:tic_tac_game/logic/game_repository.dart';
import 'package:tic_tac_game/logic/models.dart';
import 'package:tic_tac_game/logic/game_model.dart';

import 'bloc/bloc_event.dart';
import 'bloc/game_bloc.dart';
import 'board_vidget.dart';

class GameWidget extends StatelessWidget {
  const GameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => GetIt.instance.get<GameRepository>(),
        child: MultiBlocProvider(providers: [
          BlocProvider<GameModelBloc>(
            create: (context) => GameModelBloc(
              gameRepository: context.read<GameRepository>(),
            )..add(
                GetGameModel(),
              ),
          ),
        ], child: const GameLayoutProvider()));
  }
}

class GameLayoutProvider extends StatelessWidget {
  const GameLayoutProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameModelBloc, GameModelState>(
      buildWhen: (previous, current) => current.status.isSuccess,
      builder: (context, state) {
        return GameLayout(state.gameModel ?? defaultGameModel);
      },
    );
  }
}

class GameLayout extends StatelessWidget {
  late GameModel viewModel;

  GameLayout(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    if (viewModel.nextSymbol == TicTacSymbol.cross) {
      iconData = Icons.close_rounded;
    } else {
      iconData = Icons.circle_outlined;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe Game'),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const Text("Next Step"),
        SizedBox(
          width: 64,
          height: 64,
          child: Icon(iconData),
        ),
        BoardWidget(viewModel.board, (point) {
          context.read<GameModelBloc>().add(OnCellTapped(point));
        }),
        OutlinedButton(
            onPressed: () {
              context.read<GameModelBloc>().add(ResetGameModel());
            },
            child: const Icon(Icons.refresh_outlined)),
        OutlinedButton(
            onPressed: () => context.go('/game_settings'),
            child: const Text('Settings')),
        OutlinedButton(
            onPressed: () => context.go('/'), child: const Text('Back')),
      ]),
    );
  }
}
