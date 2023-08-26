import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/game_repository.dart';
import 'bloc_event.dart';
import 'bloc_state.dart';

class SettingsGameWithCompBloc extends Bloc<SettingsGameWithCompEvent, GameWithCompState> {
  SettingsGameWithCompBloc({
    required this.gameRepository,
  }) : super(const GameWithCompState()) {
    on<GetGameWithComp>(_mapGetGameWithCompEventToState);
    on<SelectGameWithComp>(_mapSelectGameWithCompEventToState);
  }

  final GameRepository gameRepository;

  void _mapGetGameWithCompEventToState(
      GetGameWithComp event, Emitter<GameWithCompState> emit) async {
    emit(state.copyWith(status: GameWithCompStatus.loading));
    try {
      final gameWithComp = await gameRepository.isGameWithComp();
      emit(
        state.copyWith(
          status: GameWithCompStatus.success,
          gameWithComp: gameWithComp,
        ),
      );
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print(stacktrace);
      }
      emit(state.copyWith(status: GameWithCompStatus.error));
    }
  }

  void _mapSelectGameWithCompEventToState(
      SelectGameWithComp event, Emitter<GameWithCompState> emit) async {
    await gameRepository.setGameWithComp(event.gameWithComp);
    emit(
      state.copyWith(
        status: GameWithCompStatus.selected,
        gameWithComp: event.gameWithComp,
      ),
    );
  }
}
