import 'package:flutter/material.dart';
import 'package:tic_tac_game/models.dart';
import 'package:tic_tac_game/game_model.dart';

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

  @override
  void initState() {
    viewModel = GameModel();
    board = viewModel.board;
    super.initState();
  }

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
          viewModel.onCellTapped(point);
          setState(() {});
        }),
        OutlinedButton(
            onPressed: () {
              viewModel.reset();
              setState(() {});
            },
            child: const Icon(Icons.refresh_outlined))
      ]),
    );
  }
}
