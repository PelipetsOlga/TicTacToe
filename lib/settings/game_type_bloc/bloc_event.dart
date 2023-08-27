import 'package:equatable/equatable.dart';

import '../../logic/models.dart';

abstract class SettingsGameTypeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetGameType extends SettingsGameTypeEvent {}

class SelectGameType extends SettingsGameTypeEvent {
  SelectGameType({
    required this.gameType,
  });
  final GameType gameType;

  @override
  List<Object?> get props => [gameType];
}