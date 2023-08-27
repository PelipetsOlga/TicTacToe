import 'package:equatable/equatable.dart';
import '../../logic/models.dart';

abstract class GameModelEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetGameModel extends GameModelEvent {}

class UpdateGameModel extends GameModelEvent {}

class ResetGameModel extends GameModelEvent {}

class OnCellTapped extends GameModelEvent {
  final Point point;

  OnCellTapped(this.point);

  @override
  List<Object?> get props => [point];
}
