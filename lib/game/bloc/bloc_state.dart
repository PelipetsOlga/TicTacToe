import 'package:equatable/equatable.dart';
import 'package:tic_tac_game/logic/game_model.dart';

enum GameModelStatus { initial, success, error, loading, selected }

extension GameModelStatusX on GameModelStatus {
  bool get isInitial => this == GameModelStatus.initial;

  bool get isSuccess => this == GameModelStatus.success;

  bool get isError => this == GameModelStatus.error;

  bool get isLoading => this == GameModelStatus.loading;

  bool get isSelected => this == GameModelStatus.selected;
}

class GameModelState extends Equatable {
  final GameModelStatus status;
  final GameModel? gameModel;
  final int? crossCount;
  final int? ovalCount;

  const GameModelState(
      {this.status = GameModelStatus.initial,
      this.gameModel,
      this.crossCount,
      this.ovalCount});

  @override
  List<Object?> get props => [status, gameModel, crossCount, ovalCount];

  GameModelState copyWith({
    GameModelStatus? status,
    GameModel? gameModel,
  }) {
    return GameModelState(
      status: status ?? this.status,
      gameModel: gameModel ?? this.gameModel,
      crossCount: gameModel?.crossCount() ?? crossCount,
      ovalCount: gameModel?.ovalCount() ?? ovalCount,
    );
  }
}
