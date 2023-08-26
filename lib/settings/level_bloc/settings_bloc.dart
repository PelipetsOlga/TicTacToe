import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/game_repository.dart';
import 'bloc_event.dart';
import 'bloc_state.dart';

class SettingsLevelBloc extends Bloc<SettingsLevelEvent, LevelState> {
  SettingsLevelBloc({
    required this.gameRepository,
  }) : super(const LevelState()) {
    on<GetLevel>(_mapGetLevelEventToState);
    on<SelectLevel>(_mapSelectLevelEventToState);
  }

  final GameRepository gameRepository;

  void _mapGetLevelEventToState(
      GetLevel event, Emitter<LevelState> emit) async {
    emit(state.copyWith(status: LevelStatus.loading));
    try {
      final selectedLevel = await gameRepository.getLevel();
      emit(
        state.copyWith(
          status: LevelStatus.success,
          selectedLevel: selectedLevel,
        ),
      );
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print(stacktrace);
      }
      emit(state.copyWith(status: LevelStatus.error));
    }
  }

  void _mapSelectLevelEventToState(
      SelectLevel event, Emitter<LevelState> emit) async {
    await gameRepository.setLevel(event.level);
    emit(
      state.copyWith(
        status: LevelStatus.selected,
        selectedLevel: event.level,
      ),
    );
  }
}
