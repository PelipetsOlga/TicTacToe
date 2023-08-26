
import 'package:tic_tac_game/logic/models.dart';
import 'package:tic_tac_game/logic/utils.dart';

class GameModel {
  late Board board;
  late TicTacSymbol nextSymbol;
  Level level;
  WhosTurnBeFirst whoFirst;
  GameType gameType;
  bool gameWithComp;

  GameModel(this.level, this.whoFirst, this.gameType, this.gameWithComp) {
    reset();
  }

  void reset() {
    board = Board(gameType.fieldSize, gameType.winLength, gameWithComp);
    nextSymbol = TicTacSymbol.cross;
  }

  void onCellTapped(Point point) {
    if (_checkIfCanSetSymbol(point)) {
      _setSymbol(point);
      _checkWinner(point);
    }
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
    List<Cell> winner = _getWinner(point);
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

  List<Cell> _getWinner(Point point) {
    List<Cell> winner = _getWinnerHorizontals(point);
    if (winner.isEmpty) {
      winner = _getWinnerVerticales(point);
    }
    if (winner.isEmpty) {
      winner = _getWinnerLeftDiagonal(point);
    }
    if (winner.isEmpty) {
      winner = _getWinnerRightDiagonal(point);
    }
    return winner;
  }

  List<Cell> _getWinnerHorizontals(Point point) {
    return _getLineHorizontal(point, board.winLength);
  }

  List<Cell> _getWinnerVerticales(Point point) {
    return _getLineVertical(point, board.winLength);
  }

  List<Cell> _getWinnerLeftDiagonal(Point point) {
    return _getLineLeftDiagonal(point, board.winLength);
  }

  List<Cell> _getWinnerRightDiagonal(Point point) {
    return _getLineRightDiagonal(point, board.winLength);
  }

  List<Cell> _getLineHorizontal(Point point, int maxLength) {
    List<Cell> winner = [];
    winner.add(_getCell(point));
    for (int index = 1; index < board.fieldSize; index++) {
      try {
        winner.addAll(board.cells.where((cell) =>
            cell.point.x == (point.x - index) &&
            cell.point.y == point.y &&
            cell.symbol == nextSymbol));
      } on Exception catch (_) {}

      try {
        winner.addAll(board.cells.where((cell) =>
            cell.point.x == (point.x + index) &&
            cell.point.y == point.y &&
            cell.symbol == nextSymbol));
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

  List<Cell> _getLineVertical(Point point, int lineLength) {
    List<Cell> winner = [];
    winner.add(_getCell(point));
    for (int index = 1; index < board.fieldSize; index++) {
      try {
        winner.addAll(board.cells.where((cell) =>
            cell.point.y == (point.y - index) &&
            cell.point.x == point.x &&
            cell.symbol == nextSymbol));
      } on Exception catch (_) {}

      try {
        winner.addAll(board.cells.where((cell) =>
            cell.point.y == (point.y + index) &&
            cell.point.x == point.x &&
            cell.symbol == nextSymbol));
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

  List<Cell> _getLineLeftDiagonal(Point point, int lineLength) {
    List<Cell> winner = [];
    winner.add(_getCell(point));
    for (int index = 1; index < board.fieldSize; index++) {
      try {
        winner.addAll(board.cells.where((cell) =>
            cell.point.y == (point.y - index) &&
            cell.point.x == (point.x - index) &&
            cell.symbol == nextSymbol));
      } on Exception catch (_) {}

      try {
        winner.addAll(board.cells.where((cell) =>
            cell.point.y == (point.y + index) &&
            cell.point.x == (point.x + index) &&
            cell.symbol == nextSymbol));
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

  List<Cell> _getLineRightDiagonal(Point point, int lineLength) {
    List<Cell> winner = [];
    winner.add(_getCell(point));
    for (int index = 1; index < board.fieldSize; index++) {
      try {
        winner.addAll(board.cells.where((cell) =>
            cell.point.y == (point.y + index) &&
            cell.point.x == (point.x - index) &&
            cell.symbol == nextSymbol));
      } on Exception catch (_) {}

      try {
        winner.addAll(board.cells.where((cell) =>
            cell.point.y == (point.y - index) &&
            cell.point.x == (point.x + index) &&
            cell.symbol == nextSymbol));
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
    if (_countAllSymbolCells(nextSymbol) == 0) {
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
    List<Cell> existingMarkedCells =
        board.cells.where((element) => element.symbol == nextSymbol).toList();

    //Find start and end of existing lines
    for (int length = board.winLength - 1; length > 1; length--) {
      List<Cell> suggestedCells = [];

      for (Cell markedCell in existingMarkedCells) {
        suggestedCells.addAll(_suggestedHorizontalCells(
            _getLineHorizontal(markedCell.point, length)));
        suggestedCells.addAll(_suggestedVerticalCells(
            _getLineVertical(markedCell.point, length)));
        suggestedCells.addAll(_suggestedLeftDiagonalCells(
            _getLineLeftDiagonal(markedCell.point, length)));
        suggestedCells.addAll(_suggestedRightDiagonalCells(
            _getLineRightDiagonal(markedCell.point, length)));
      } //
      if (suggestedCells.isNotEmpty && suggestedCells.length > 1) {
        return getTheMostPopular(suggestedCells).point;
      } else if (suggestedCells.isNotEmpty && suggestedCells.length > 1) {
        return suggestedCells.first.point;
      }
      //}
    }

    //Find cells around existing cells
    List<Cell> suggestedNeighbourCells = [];
    for (var cell in existingMarkedCells) {
      suggestedNeighbourCells.addAll(_getNeighbourEmptyCells(cell));
    }
    if (suggestedNeighbourCells.isNotEmpty &&
        suggestedNeighbourCells.length > 1) {
      return getTheMostPopular(suggestedNeighbourCells).point;
    } else if (suggestedNeighbourCells.isNotEmpty) {
      return suggestedNeighbourCells.first.point;
    }

    return const Point(0, 0);
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
}
