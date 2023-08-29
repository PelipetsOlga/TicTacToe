import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tic_tac_game/game/cell_widget.dart';
import 'package:tic_tac_game/logic/models.dart';

typedef CellTapCallback = void Function(Point point);

class BoardWidget extends StatelessWidget {
  Board board;
  CellTapCallback callback;
  String boardBackgroundImage;
  int cellSize;

  BoardWidget(
      this.board, this.callback, this.boardBackgroundImage, this.cellSize,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
        child: SvgPicture.asset(
          boardBackgroundImage,
          semanticsLabel: 'Board',
          width: 300,
          height: 300,
          fit: BoxFit.fill,
        ),
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: chunk(board.cells, board.fieldSize)
              .map((row) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: row
                        .map((cell) => CellWidget(
                            cell.symbol,
                            () => callback(cell.point),
                            cell.isWinner,
                            cellSize.toDouble()))
                        .toList(),
                  ))
              .toList(),
        ),
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
