import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tic_tac_game/game/cell_widget.dart';
import 'package:tic_tac_game/logic/models.dart';

typedef CellTapCallback = void Function(Point point);

class BoardWidget extends StatelessWidget {
  Board board;
  CellTapCallback callback;

  BoardWidget(this.board, this.callback, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
        child: SvgPicture.asset(
          'assets/board_3_3.svg',
          semanticsLabel: 'Board',
          width: 300,
          height: 300,
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: chunk(board.cells, board.fieldSize)
            .map((row) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: row
                      .map((cell) => CellWidget(cell.symbol,
                          () => callback(cell.point), cell.isWinner))
                      .toList(),
                ))
            .toList(),
      ),
    ]);
  }
}

List<List<dynamic>> chunk(List<dynamic> array, int size) {
  List<List<dynamic>> chunks = [];
  int i = 0;
  while (i < array.length) {
    int j = i + size;
    chunks.add(array.sublist(i, j > array.length ? array.length : j));
    i = j;
  }
  return chunks;
}
