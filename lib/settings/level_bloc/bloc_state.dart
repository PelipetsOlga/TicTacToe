import 'package:equatable/equatable.dart';

import '../../logic/models.dart';

enum LevelStatus { initial, success, error, loading, selected }

extension LevelStatusX on LevelStatus {
  bool get isInitial => this == LevelStatus.initial;

  bool get isSuccess => this == LevelStatus.success;

  bool get isError => this == LevelStatus.error;

  bool get isLoading => this == LevelStatus.loading;

  bool get isSelected => this == LevelStatus.selected;
}

class LevelState extends Equatable {
  final LevelStatus status;
  final Level selectedLevel;

  const LevelState({
    this.status = LevelStatus.initial,
    this.selectedLevel = Level.easy,
  });

  @override
  List<Object?> get props => [status, selectedLevel];

  LevelState copyWith({
    LevelStatus? status,
    Level? selectedLevel,
  }) {
    return LevelState(
      status: status ?? this.status,
      selectedLevel: selectedLevel ?? this.selectedLevel,
    );
  }
}