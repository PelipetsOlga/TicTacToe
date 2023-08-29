import 'package:equatable/equatable.dart';

enum SoundStatus { initial, success, error, loading, selected }

extension SoundStatusX on SoundStatus {
  bool get isInitial => this == SoundStatus.initial;

  bool get isSuccess => this == SoundStatus.success;

  bool get isError => this == SoundStatus.error;

  bool get isLoading => this == SoundStatus.loading;

  bool get isSelected => this == SoundStatus.selected;
}

class SoundState extends Equatable {
  final SoundStatus status;
  final bool turnedOn;

  const SoundState({
    this.status = SoundStatus.initial,
    this.turnedOn = true,
  });

  @override
  List<Object?> get props => [status, turnedOn];

  SoundState copyWith({
    SoundStatus? status,
    bool? turnedOn,
  }) {
    return SoundState(
      status: status ?? this.status,
      turnedOn: turnedOn ?? this.turnedOn,
    );
  }
}
