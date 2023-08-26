import 'package:equatable/equatable.dart';

enum TicTacSymbol { cross, oval, none }

enum Level { easy, middle, hard }

enum WhosTurnBeFirst { me, opponent }

// First and second number is the size of board
// Third number is the size of line to win
enum GameType { g_3_3_3, g_4_4_3, g_5_5_3, g_5_5_4, g_5_5_5, g_6_6_4 }

class Point extends Equatable {
  final int x;
  final int y;

  const Point(this.x, this.y);

  @override
  List<Object?> get props => [x, y];
}

class Cell extends Equatable {
  Point point;
  TicTacSymbol symbol;
  bool isWinner;

  Cell(this.point, this.symbol, this.isWinner);

  @override
  List<Object?> get props => [point, symbol, isWinner];
}

class Board extends Equatable {
  late List<Cell> cells;
  int fieldSize;
  int winLength;
  bool gameWithComp;

  Board(this.fieldSize, this.winLength, this.gameWithComp) {
    _initBoard();
  }

  void _initBoard() {
    if (fieldSize == 0 || winLength == 0) {
      cells = [];
      return;
    }
    cells = [];
    for (var i = 0; i < fieldSize; i++) {
      for (var j = 0; j < fieldSize; j++) {
        cells.add(Cell(Point(j, i), TicTacSymbol.none, false));
      }
    }
  }

  @override
  List<Object?> get props => [cells, fieldSize, winLength];
}
