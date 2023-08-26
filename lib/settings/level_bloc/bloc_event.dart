import 'package:equatable/equatable.dart';

import '../../logic/models.dart';

abstract class SettingsLevelEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetLevel extends SettingsLevelEvent {}

class SelectLevel extends SettingsLevelEvent {
  SelectLevel({
    required this.level,
  });
  final Level level;

  @override
  List<Object?> get props => [level];
}