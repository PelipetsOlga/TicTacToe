import 'package:tic_tac_game/models.dart';

class ViewModel {
  late Board board;
  late TicTacSymbol nextSymbol;

  ViewModel() {
    reset();
  }

  void reset() {
    board = Board(5, 3);
    nextSymbol = TicTacSymbol.cross;
  }

  void onCellTapped(Point point) {
    if (_checkIfCanSetSymbol(point)) {
      _setSymbol(point);
      _checkWinner(point);
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
    return Cell(const Point(0, 0), TicTacSymbol.none, false);
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
    if (winner.length < board.winLength) return [];
    if (_checkProgressionContinuity(
        winner.map((cell) => cell.point.x).toList()..sort())) {
      return winner;
    } else {
      return [];
    }
  }

  List<Cell> _getWinnerVerticales(Point point) {
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
    if (winner.length < board.winLength) return [];
    if (_checkProgressionContinuity(
        winner.map((cell) => cell.point.y).toList()..sort())) {
      return winner;
    } else {
      return [];
    }
  }

  List<Cell> _getWinnerLeftDiagonal(Point point) {
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
    if (winner.length < board.winLength) return [];
    if (_checkProgressionContinuity(
        winner.map((cell) => cell.point.y).toList()..sort())) {
      return winner;
    } else {
      return [];
    }
  }

  List<Cell> _getWinnerRightDiagonal(Point point) {
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
    if (winner.length < board.winLength) return [];
    if (_checkProgressionContinuity(
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
}

bool _checkProgressionContinuity(List<int> sortedList) {
  return sortedList.last - sortedList.first == sortedList.length - 1;
}
