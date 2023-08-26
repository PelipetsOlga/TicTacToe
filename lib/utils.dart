import 'dart:math';

import 'logic/models.dart';

bool checkProgressionContinuity(List<int> sortedList) {
  return sortedList.last - sortedList.first == sortedList.length - 1;
}

T getRandomElement<T>(List<T> list) {
  final random = Random();
  var i = random.nextInt(list.length);
  return list[i];
}

void sortHorizontalLines(List<Cell> original) {
  original.sort((a, b) => a.point.x.compareTo(b.point.x));
}

void sortVerticalLines(List<Cell> original) {
  original.sort((a, b) => a.point.y.compareTo(b.point.y));
}

void sortLeftDiagonalLines(List<Cell> original) {
  original.sort((a, b) => a.point.x.compareTo(b.point.x));
}

void sortRightDiagonalLines(List<Cell> original) {
  original.sort((a, b) => a.point.x.compareTo(b.point.x));
}

Cell getTheMostPopular(List<Cell> longList) {
  Map<Cell, int> map = {};
  for (var cell in longList) {
    if (map.containsKey(cell)) {
      int oldValue = map[cell] ?? 0;
      map[cell] = oldValue + 1;
    } else {
      map[cell] = 1;
    }
  }
  var max = map.entries.first;
  for (var entry in map.entries) {
    if (entry.value > max.value) {
      max = entry;
    }
  }

  List<Cell> maxCells = map.entries
      .where((entry) => entry.value == max.value)
      .map((e) => e.key)
      .toList();

  return getRandomElement(maxCells);
}
