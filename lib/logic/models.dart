import 'package:equatable/equatable.dart';

enum TicTacSymbol { cross, oval, none }

enum Level { easy, middle, hard }

enum WhosTurnBeFirst { me, opponent, alternately }

// First and second number is the size of board
// Third number is the size of line to win
enum GameType { g_3_3_3, g_4_4_3, g_5_5_3, g_5_5_4, g_5_5_5, g_6_6_4 }

extension GameTypeExtension on GameType {
  int get fieldSize {
    switch (this) {
      case GameType.g_3_3_3:
        return 3;
      case GameType.g_4_4_3:
        return 4;
      case GameType.g_5_5_3:
        return 5;
      case GameType.g_5_5_4:
        return 5;
      case GameType.g_5_5_5:
        return 5;
      case GameType.g_6_6_4:
        return 6;
      default:
        return 3;
    }
  }

  int get winLength {
    switch (this) {
      case GameType.g_3_3_3:
        return 3;
      case GameType.g_4_4_3:
        return 3;
      case GameType.g_5_5_3:
        return 3;
      case GameType.g_5_5_4:
        return 4;
      case GameType.g_5_5_5:
        return 5;
      case GameType.g_6_6_4:
        return 4;
      default:
        return 3;
    }
  }

  String get boardBackgroundImage {
    switch (this) {
      case GameType.g_3_3_3:
        return 'assets/board_300_3_3.svg';
      case GameType.g_4_4_3:
        return 'assets/board_300_4_4.svg';
      case GameType.g_5_5_3:
        return 'assets/board_300_5_5.svg';
      case GameType.g_5_5_4:
        return 'assets/board_300_5_5.svg';
      case GameType.g_5_5_5:
        return 'assets/board_300_5_5.svg';
      case GameType.g_6_6_4:
        return 'assets/board_300_6_6.svg';
      default:
        return 'assets/board_300_3_3.svg';
    }
  }

  int get cellSize {
    switch (this) {
      case GameType.g_3_3_3:
        return 100;
      case GameType.g_4_4_3:
        return 75;
      case GameType.g_5_5_3:
        return 60;
      case GameType.g_5_5_4:
        return 60;
      case GameType.g_5_5_5:
        return 60;
      case GameType.g_6_6_4:
        return 50;
      default:
        return 100;
    }
  }
}

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
