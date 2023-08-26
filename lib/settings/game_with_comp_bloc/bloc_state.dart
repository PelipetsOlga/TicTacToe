import 'package:equatable/equatable.dart';


enum GameWithCompStatus { initial, success, error, loading, selected }

extension GameWithCompStatusX on GameWithCompStatus {
  bool get isInitial => this == GameWithCompStatus.initial;

  bool get isSuccess => this == GameWithCompStatus.success;

  bool get isError => this == GameWithCompStatus.error;

  bool get isLoading => this == GameWithCompStatus.loading;

  bool get isSelected => this == GameWithCompStatus.selected;
}

class GameWithCompState extends Equatable {
  final GameWithCompStatus status;
  final bool gameWithComp;

  const GameWithCompState({
    this.status = GameWithCompStatus.initial,
    this.gameWithComp = true,
  });

  @override
  List<Object?> get props => [status, gameWithComp];

  GameWithCompState copyWith({
    GameWithCompStatus? status,
    bool? gameWithComp,
  }) {
    return GameWithCompState(
      status: status ?? this.status,
      gameWithComp: gameWithComp ?? this.gameWithComp,
    );
  }
}