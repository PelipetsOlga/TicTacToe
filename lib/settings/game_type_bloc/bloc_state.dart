import 'package:equatable/equatable.dart';

import '../../logic/models.dart';

enum GameTypeStatus { initial, success, error, loading, selected }

extension GameTypeStatusX on GameTypeStatus {
  bool get isInitial => this == GameTypeStatus.initial;

  bool get isSuccess => this == GameTypeStatus.success;

  bool get isError => this == GameTypeStatus.error;

  bool get isLoading => this == GameTypeStatus.loading;

  bool get isSelected => this == GameTypeStatus.selected;
}

class GameTypeState extends Equatable {
  final GameTypeStatus status;
  final GameType selectedGameType;

  const GameTypeState({
    this.status = GameTypeStatus.initial,
    this.selectedGameType = GameType.g_3_3_3,
  });

  @override
  List<Object?> get props => [status, selectedGameType];

  GameTypeState copyWith({
    GameTypeStatus? status,
    GameType? selectedGameType,
  }) {
    return GameTypeState(
      status: status ?? this.status,
      selectedGameType: selectedGameType ?? this.selectedGameType,
    );
  }
}