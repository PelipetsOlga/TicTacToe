import 'package:tic_tac_game/logic/models.dart';
import 'package:tic_tac_game/logic/utils.dart';

final defaultGameModel =
    GameModel(Level.easy, WhosTurnBeFirst.alternately, GameType.g_3_3_3, true);

class GameModel {
  late Board board;
  late TicTacSymbol nextSymbol;
  Level level;
  WhosTurnBeFirst whoFirst;
  GameType gameType;
  bool gameWithComp;
  bool myMoveFirstWhenAlternate = true;

  GameModel(this.level, this.whoFirst, this.gameType, this.gameWithComp) {
    reset();
  }

  void reset() {
    board = Board(gameType.fieldSize, gameType.winLength, gameWithComp);
    nextSymbol = TicTacSymbol.cross;
    if (whoFirst == WhosTurnBeFirst.alternately) {
      myMoveFirstWhenAlternate = !myMoveFirstWhenAlternate;
    }
    if (board.gameWithComp &&
        ((whoFirst == WhosTurnBeFirst.opponent) ||
            (whoFirst == WhosTurnBeFirst.alternately &&
                !myMoveFirstWhenAlternate))) {
      nextSymbol = TicTacSymbol.oval;
      compNextStep();
    }
  }

  void onCellTapped(Point point) {
    if (_checkIfCanSetSymbol(point)) {
      _setSymbol(point);
      _checkWinner(point);
    }
  }

  void opponentMove() {
    if (nextSymbol != TicTacSymbol.none && board.gameWithComp) {
      compNextStep();
    }
  }

  bool _checkIfCanSetSymbol(Point point) {
    return _getCell(point).symbol == TicTacSymbol.none &&
        !board.cells.any((element) => element.isWinner);
  }

  void _setSymbol(Point point) {
    _getCell(point).symbol = nextSymbol;
  }

  void _checkWinner(Point point) {
    List<Cell> winner = _getWinner(point, nextSymbol);
    if (winner.length >= board.winLength) {
      _markWinner(winner);
      nextSymbol = TicTacSymbol.none;
    } else {
      _switchNextSymbol();
    }
  }

  Cell _getCell(Point point) {
    for (Cell cell in board.cells) {
      if (cell.point == point) return cell;
    }
    // return Cell(const Point(0, 0), TicTacSymbol.none, false);
    throw Exception("Index Out Bond Exception for x=${point.x}, y=${point.y}");
  }

  void _switchNextSymbol() {
    if (nextSymbol == TicTacSymbol.cross) {
      nextSymbol = TicTacSymbol.oval;
    } else {
      nextSymbol = TicTacSymbol.cross;
    }
  }

  List<Cell> _getWinner(Point point, TicTacSymbol symbol) {
    List<Cell> winner = _getWinnerHorizontals(point, symbol);
    if (winner.isEmpty) {
      winner = _getWinnerVerticales(point, symbol);
    }
    if (winner.isEmpty) {
      winner = _getWinnerLeftDiagonal(point, symbol);
    }
    if (winner.isEmpty) {
      winner = _getWinnerRightDiagonal(point, symbol);
    }
    return winner;
  }

  List<Cell> _getWinnerHorizontals(Point point, TicTacSymbol symbol) {
    return _getLineHorizontal(point, board.winLength, symbol);
  }

  List<Cell> _getWinnerVerticales(Point point, TicTacSymbol symbol) {
    return _getLineVertical(point, board.winLength, symbol);
  }

  List<Cell> _getWinnerLeftDiagonal(Point point, TicTacSymbol symbol) {
    return _getLineLeftDiagonal(point, board.winLength, symbol);
  }

  List<Cell> _getWinnerRightDiagonal(Point point, TicTacSymbol symbol) {
    return _getLineRightDiagonal(point, board.winLength, symbol);
  }

  List<Cell> _getLineHorizontal(
      Point point, int maxLength, TicTacSymbol symbol) {
    List<Cell> winner = [];
    winner.add(_getCell(point));
    for (int index = 1; index < board.fieldSize; index++) {
      try {
        winner.addAll(board.cells.where((cell) =>
            cell.point.x == (point.x - index) &&
            cell.point.y == point.y &&
            cell.symbol == symbol));
      } on Exception catch (_) {}

      try {
        winner.addAll(board.cells.where((cell) =>
            cell.point.x == (point.x + index) &&
            cell.point.y == point.y &&
            cell.symbol == symbol));
      } on Exception catch (_) {}
    }
    if (winner.length < maxLength) return [];
    sortHorizontalLines(winner);
    if (checkProgressionContinuity(
        winner.map((cell) => cell.point.x).toList()..sort())) {
      return winner;
    } else {
      return [];
    }
  }

  List<Cell> _getLineVertical(
      Point point, int lineLength, TicTacSymbol symbol) {
    List<Cell> winner = [];
    winner.add(_getCell(point));
    for (int index = 1; index < board.fieldSize; index++) {
      try {
        winner.addAll(board.cells.where((cell) =>
            cell.point.y == (point.y - index) &&
            cell.point.x == point.x &&
            cell.symbol == symbol));
      } on Exception catch (_) {}

      try {
        winner.addAll(board.cells.where((cell) =>
            cell.point.y == (point.y + index) &&
            cell.point.x == point.x &&
            cell.symbol == symbol));
      } on Exception catch (_) {}
    }
    if (winner.length < lineLength) return [];
    sortVerticalLines(winner);
    if (checkProgressionContinuity(
        winner.map((cell) => cell.point.y).toList()..sort())) {
      return winner;
    } else {
      return [];
    }
  }

  List<Cell> _getLineLeftDiagonal(
      Point point, int lineLength, TicTacSymbol symbol) {
    List<Cell> winner = [];
    winner.add(_getCell(point));
    for (int index = 1; index < board.fieldSize; index++) {
      try {
        winner.addAll(board.cells.where((cell) =>
            cell.point.y == (point.y - index) &&
            cell.point.x == (point.x - index) &&
            cell.symbol == symbol));
      } on Exception catch (_) {}

      try {
        winner.addAll(board.cells.where((cell) =>
            cell.point.y == (point.y + index) &&
            cell.point.x == (point.x + index) &&
            cell.symbol == symbol));
      } on Exception catch (_) {}
    }
    if (winner.length < lineLength) return [];
    sortLeftDiagonalLines(winner);
    if (checkProgressionContinuity(
        winner.map((cell) => cell.point.y).toList()..sort())) {
      return winner;
    } else {
      return [];
    }
  }

  List<Cell> _getLineRightDiagonal(
      Point point, int lineLength, TicTacSymbol symbol) {
    List<Cell> winner = [];
    winner.add(_getCell(point));
    for (int index = 1; index < board.fieldSize; index++) {
      try {
        winner.addAll(board.cells.where((cell) =>
            cell.point.y == (point.y + index) &&
            cell.point.x == (point.x - index) &&
            cell.symbol == symbol));
      } on Exception catch (_) {}

      try {
        winner.addAll(board.cells.where((cell) =>
            cell.point.y == (point.y - index) &&
            cell.point.x == (point.x + index) &&
            cell.symbol == symbol));
      } on Exception catch (_) {}
    }
    if (winner.length < lineLength) return [];
    sortRightDiagonalLines(winner);
    if (checkProgressionContinuity(
        winner.map((cell) => cell.point.y).toList()..sort())) {
      return winner;
    } else {
      return [];
    }
  }

  void _markWinner(List<Cell> winner) {
    for (var element in winner) {
      element.isWinner = true;
    }
  }

  void compNextStep() {
    Point point = _calculateCompStep();
    if (_checkIfCanSetSymbol(point)) {
      _setSymbol(point);
      _checkWinner(point);
    }
  }

  Point _calculateCompStep() {
    if (_countAllSymbolCells(TicTacSymbol.oval) == 0 &&
        _countAllSymbolCells(TicTacSymbol.cross) > 0 &&
        level == Level.hard) {
      return _calculateCompNextStep();
    } else if (_countAllSymbolCells(TicTacSymbol.oval) == 0) {
      return _calculateCompFirstStep();
    } else {
      return _calculateCompNextStep();
    }
  }

  int _countAllSymbolCells(TicTacSymbol symbol) {
    return board.cells
        .where((element) => element.symbol == symbol)
        .toList()
        .length;
  }

  Point _calculateCompFirstStep() {
    List<Cell> freeCells = board.cells
        .where((element) => element.symbol == TicTacSymbol.none)
        .toList();
    return getRandomElement(freeCells).point;
  }

  Point _calculateCompNextStep() {
    // I always play cross
    // Opponent always play oval

    List<Cell> opponentExistingMarkedCells = board.cells
        .where((element) => element.symbol == TicTacSymbol.oval)
        .toList();

    List<Cell> myExistingMarkedCells = board.cells
        .where((element) => element.symbol == TicTacSymbol.cross)
        .toList();

    List<Cell> mySuggestedCells = [];
    List<Cell> myNeighbourCells = [];
    List<Cell> myFinalSuggestedCells = [];

    if (level != Level.easy) {
      // Calculate my suggested cells to continue existing lines
      for (int length = board.winLength - 1; length > 1; length--) {
        for (Cell markedCell in myExistingMarkedCells) {
          var suggestedHorizontalCells = _suggestedHorizontalCells(
              _getLineHorizontal(markedCell.point, length, TicTacSymbol.cross));
          for (int i = 0; i < length; i++) {
            mySuggestedCells.addAll(suggestedHorizontalCells);
          }

          var suggestedVerticalCells = _suggestedVerticalCells(
              _getLineVertical(markedCell.point, length, TicTacSymbol.cross));
          for (int i = 0; i < length; i++) {
            mySuggestedCells.addAll(suggestedVerticalCells);
          }

          var suggestedLeftDiagonalCells = _suggestedLeftDiagonalCells(
              _getLineLeftDiagonal(
                  markedCell.point, length, TicTacSymbol.cross));
          for (int i = 0; i < length; i++) {
            mySuggestedCells.addAll(suggestedLeftDiagonalCells);
          }

          var suggestedRightDiagonalCells = _suggestedRightDiagonalCells(
              _getLineRightDiagonal(
                  markedCell.point, length, TicTacSymbol.cross));
          for (int i = 0; i < length; i++) {
            mySuggestedCells.addAll(suggestedRightDiagonalCells);
          }
        }
      }
    }

    // Calculate my suggested cells around my single cells
    if (level == Level.hard) {
      for (var cell in myExistingMarkedCells) {
        myNeighbourCells.addAll(_getNeighbourEmptyCells(cell));
      }
    }

    myFinalSuggestedCells.addAll(mySuggestedCells);
    myFinalSuggestedCells.addAll(myNeighbourCells);

    //Find start and end of opponent's existing lines
    for (int length = board.winLength - 1; length > 1; length--) {
      List<Cell> opponentSuggestedCells = [];

      for (Cell markedCell in opponentExistingMarkedCells) {
        var suggestedHorizontalCells = _suggestedHorizontalCells(
            _getLineHorizontal(markedCell.point, length, TicTacSymbol.oval));
        for (int i = 0; i < length; i++) {
          opponentSuggestedCells.addAll(suggestedHorizontalCells);
        }

        var suggestedVerticalCells = _suggestedVerticalCells(
            _getLineVertical(markedCell.point, length, TicTacSymbol.oval));
        for (int i = 0; i < length; i++) {
          opponentSuggestedCells.addAll(suggestedVerticalCells);
        }

        var suggestedLeftDiagonalCells = _suggestedLeftDiagonalCells(
            _getLineLeftDiagonal(markedCell.point, length, TicTacSymbol.oval));
        for (int i = 0; i < length; i++) {
          opponentSuggestedCells.addAll(suggestedLeftDiagonalCells);
        }

        var suggestedRightDiagonalCells = _suggestedRightDiagonalCells(
            _getLineRightDiagonal(markedCell.point, length, TicTacSymbol.oval));
        for (int i = 0; i < length; i++) {
          opponentSuggestedCells.addAll(suggestedRightDiagonalCells);
        }
      }

      // If opponent has lines then his move is to continue them
      if (opponentSuggestedCells.isNotEmpty) {
        opponentSuggestedCells.addAll(myFinalSuggestedCells);
        return getTheMostPopular(opponentSuggestedCells).point;
      }
    }

    //If opponent does't have lines, then find cells around his existing cells
    List<Cell> opponentSuggestedNeighbourCells = [];
    for (var cell in opponentExistingMarkedCells) {
      opponentSuggestedNeighbourCells.addAll(_getNeighbourEmptyCells(cell));
    }
    if (opponentSuggestedNeighbourCells.isNotEmpty) {
      opponentSuggestedNeighbourCells.addAll(myFinalSuggestedCells);
      return getTheMostPopular(opponentSuggestedNeighbourCells).point;
    }

    return getTheMostPopular(myFinalSuggestedCells).point;
  }

  List<Cell> _getNeighbourEmptyCells(Cell cell) {
    List<Cell> result = [];
    try {
      var getCell = _getCell(Point(cell.point.x - 1, cell.point.y - 1));
      if (getCell.symbol == TicTacSymbol.none) result.add(getCell);
    } on Exception catch (_) {}
    try {
      var getCell = _getCell(Point(cell.point.x + 1, cell.point.y + 1));
      if (getCell.symbol == TicTacSymbol.none) result.add(getCell);
    } on Exception catch (_) {}
    try {
      var getCell = _getCell(Point(cell.point.x, cell.point.y - 1));
      if (getCell.symbol == TicTacSymbol.none) result.add(getCell);
    } on Exception catch (_) {}
    try {
      var getCell = _getCell(Point(cell.point.x, cell.point.y + 1));
      if (getCell.symbol == TicTacSymbol.none) result.add(getCell);
    } on Exception catch (_) {}
    try {
      var getCell = _getCell(Point(cell.point.x - 1, cell.point.y));
      if (getCell.symbol == TicTacSymbol.none) result.add(getCell);
    } on Exception catch (_) {}
    try {
      var getCell = _getCell(Point(cell.point.x + 1, cell.point.y));
      if (getCell.symbol == TicTacSymbol.none) result.add(getCell);
    } on Exception catch (_) {}
    try {
      var getCell = _getCell(Point(cell.point.x + 1, cell.point.y - 1));
      if (getCell.symbol == TicTacSymbol.none) result.add(getCell);
    } on Exception catch (_) {}
    try {
      var getCell = _getCell(Point(cell.point.x - 1, cell.point.y + 1));
      if (getCell.symbol == TicTacSymbol.none) result.add(getCell);
    } on Exception catch (_) {}
    return result;
  }

  List<Cell> _suggestedHorizontalCells(List<Cell> existingLines) {
    if (existingLines.isEmpty) return [];
    List<Cell> results = [];
    try {
      var start = _getCell(Point((existingLines.firstOrNull?.point.x ?? -1) - 1,
          (existingLines.firstOrNull?.point.y ?? -1)));
      if (start.symbol == TicTacSymbol.none) {
        results.add(start);
      }
    } on Exception catch (_) {}
    try {
      var end = _getCell(Point(
          (existingLines.lastOrNull?.point.x ?? board.fieldSize) + 1,
          (existingLines.lastOrNull?.point.y ?? board.fieldSize)));
      if (end.symbol == TicTacSymbol.none) {
        results.add(end);
      }
    } on Exception catch (_) {}
    return results;
  }

  List<Cell> _suggestedVerticalCells(List<Cell> existingLines) {
    if (existingLines.isEmpty) return [];
    List<Cell> results = [];
    try {
      var start = _getCell(Point((existingLines.firstOrNull?.point.x ?? -1),
          (existingLines.firstOrNull?.point.y ?? -1) - 1));
      if (start.symbol == TicTacSymbol.none) {
        results.add(start);
      }
    } on Exception catch (_) {}
    try {
      var end = _getCell(Point(
          (existingLines.lastOrNull?.point.x ?? board.fieldSize),
          (existingLines.lastOrNull?.point.y ?? board.fieldSize) + 1));
      if (end.symbol == TicTacSymbol.none) {
        results.add(end);
      }
    } on Exception catch (_) {}
    return results;
  }

  List<Cell> _suggestedLeftDiagonalCells(List<Cell> existingLines) {
    if (existingLines.isEmpty) return [];
    List<Cell> results = [];
    try {
      var start = _getCell(Point((existingLines.firstOrNull?.point.x ?? -1) - 1,
          (existingLines.firstOrNull?.point.y ?? -1) - 1));
      if (start.symbol == TicTacSymbol.none) {
        results.add(start);
      }
    } on Exception catch (_) {}
    try {
      var end = _getCell(Point(
          (existingLines.lastOrNull?.point.x ?? board.fieldSize) + 1,
          (existingLines.lastOrNull?.point.y ?? board.fieldSize) + 1));
      if (end.symbol == TicTacSymbol.none) {
        results.add(end);
      }
    } on Exception catch (_) {}
    return results;
  }

  List<Cell> _suggestedRightDiagonalCells(List<Cell> existingLines) {
    if (existingLines.isEmpty) return [];
    List<Cell> results = [];
    try {
      var start = _getCell(Point((existingLines.firstOrNull?.point.x ?? -1) - 1,
          (existingLines.firstOrNull?.point.y ?? board.fieldSize) + 1));
      if (start.symbol == TicTacSymbol.none) {
        results.add(start);
      }
    } on Exception catch (_) {}
    try {
      var end = _getCell(Point(
          (existingLines.lastOrNull?.point.x ?? board.fieldSize) + 1,
          (existingLines.lastOrNull?.point.y ?? -1) - 1));
      if (end.symbol == TicTacSymbol.none) {
        results.add(end);
      }
    } on Exception catch (_) {}
    return results;
  }

  int crossCount() {
    return board.cells
        .where((cell) => cell.symbol == TicTacSymbol.cross)
        .toList()
        .length;
  }

  int ovalCount() {
    return board.cells
        .where((cell) => cell.symbol == TicTacSymbol.oval)
        .toList()
        .length;
  }
}
