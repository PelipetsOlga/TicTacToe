import 'package:equatable/equatable.dart';

import '../../logic/models.dart';

enum WhoFirstStatus { initial, success, error, loading, selected }

extension WhoFirstStatusX on WhoFirstStatus {
  bool get isInitial => this == WhoFirstStatus.initial;

  bool get isSuccess => this == WhoFirstStatus.success;

  bool get isError => this == WhoFirstStatus.error;

  bool get isLoading => this == WhoFirstStatus.loading;

  bool get isSelected => this == WhoFirstStatus.selected;
}

class WhoFirstState extends Equatable {
  final WhoFirstStatus status;
  final WhosTurnBeFirst who;

  const WhoFirstState({
    this.status = WhoFirstStatus.initial,
    this.who = WhosTurnBeFirst.alternately,
  });

  @override
  List<Object?> get props => [status, who];

  WhoFirstState copyWith({
    WhoFirstStatus? status,
    WhosTurnBeFirst? who,
  }) {
    return WhoFirstState(
      status: status ?? this.status,
      who: who ?? this.who,
    );
  }
}
