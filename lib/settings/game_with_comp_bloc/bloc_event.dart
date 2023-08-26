import 'package:equatable/equatable.dart';

abstract class SettingsGameWithCompEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetGameWithComp extends SettingsGameWithCompEvent {}

class SelectGameWithComp extends SettingsGameWithCompEvent {
  SelectGameWithComp({
    required this.gameWithComp,
  });

  final bool gameWithComp;

  @override
  List<Object?> get props => [gameWithComp];
}
