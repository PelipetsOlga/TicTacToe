import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/game_repository.dart';
import 'bloc_event.dart';
import 'bloc_state.dart';

class SettingsGameTypeBloc extends Bloc<SettingsGameTypeEvent, GameTypeState> {
  SettingsGameTypeBloc({
    required this.gameRepository,
  }) : super(const GameTypeState()) {
    on<GetGameType>(_mapGetGameTypeEventToState);
    on<SelectGameType>(_mapSelectGameTypeEventToState);
  }

  final GameRepository gameRepository;

  void _mapGetGameTypeEventToState(
      GetGameType event, Emitter<GameTypeState> emit) async {
    emit(state.copyWith(status: GameTypeStatus.loading));
    try {
      final selectedGameType = await gameRepository.gameType();
      emit(
        state.copyWith(
          status: GameTypeStatus.success,
          selectedGameType: selectedGameType,
        ),
      );
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print(stacktrace);
      }
      emit(state.copyWith(status: GameTypeStatus.error));
    }
  }

  void _mapSelectGameTypeEventToState(
      SelectGameType event, Emitter<GameTypeState> emit) async {
    await gameRepository.setGameType(event.gameType);
    emit(
      state.copyWith(
        status: GameTypeStatus.selected,
        selectedGameType: event.gameType,
      ),
    );
  }
}
