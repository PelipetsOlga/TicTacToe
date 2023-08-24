import 'package:flutter/material.dart';
import 'package:tic_tac_game/cell_widget.dart';
import 'package:tic_tac_game/models.dart';

typedef CellTapCallback = void Function(Point point);

class BoardWidget extends StatelessWidget {
  Board board;
  CellTapCallback callback;

  BoardWidget(this.board, this.callback, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: chunk(board.cells, board.fieldSize)
          .map((row) => Row(
                children: row
                    .map((cell) => CellWidget(
                        cell.symbol, () => callback(cell.point), cell.isWinner))
                    .toList(),
              ))
          .toList(),
    );
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
