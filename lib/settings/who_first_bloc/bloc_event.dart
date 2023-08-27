import 'package:equatable/equatable.dart';

import '../../logic/models.dart';

abstract class SettingsWhoFirstEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetWhoFirst extends SettingsWhoFirstEvent {}

class SelectWhoFirst extends SettingsWhoFirstEvent {
  SelectWhoFirst({
    required this.who,
  });
  final WhosTurnBeFirst who;

  @override
  List<Object?> get props => [who];
}