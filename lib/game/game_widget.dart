import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_game/logic/game_repository.dart';
import 'package:tic_tac_game/logic/models.dart';
import 'package:tic_tac_game/logic/game_model.dart';

import 'board_vidget.dart';

class GameWidget extends StatefulWidget {
  const GameWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return GameWidgetState();
  }
}

class GameWidgetState extends State<GameWidget> {
  late GameModel viewModel;
  late Board board;
  late GameRepository repository;

  @override
  Widget build(BuildContext context) {
    // repository = GetIt.instance.get<GameRepository>();
    // viewModel = await repository.provideGameModel();
    viewModel = GameModel(Level.easy, WhosTurnBeFirst.me, GameType.g_6_6_4, true);
    board = viewModel.board;
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
          viewModel.onCellTapped(point);
          setState(() {});
        }),
        OutlinedButton(
            onPressed: () {
              viewModel.reset();
              setState(() {});
            },
            child: const Icon(Icons.refresh_outlined)),
        OutlinedButton(
            onPressed: () => context.go('/game_settings'),
            child: Text('Settings')),
        OutlinedButton(onPressed: () => context.go('/'), child: Text('Back')),
      ]),
    );
  }
}
