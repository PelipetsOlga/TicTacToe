import 'package:equatable/equatable.dart';

abstract class SettingsSoundEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetSound extends SettingsSoundEvent {}

class SelectSound extends SettingsSoundEvent {
  SelectSound({
    required this.turnedOn,
  });

  final bool turnedOn;

  @override
  List<Object?> get props => [turnedOn];
}
