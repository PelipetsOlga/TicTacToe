import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/game_repository.dart';
import 'bloc_event.dart';
import 'bloc_state.dart';

class SettingsSoundBloc extends Bloc<SettingsSoundEvent, SoundState> {
  SettingsSoundBloc({
    required this.gameRepository,
  }) : super(const SoundState()) {
    on<GetSound>(_mapGetSoundEventToState);
    on<SelectSound>(_mapSelectSoundEventToState);
  }

  final GameRepository gameRepository;

  void _mapGetSoundEventToState(
      GetSound event, Emitter<SoundState> emit) async {
    emit(state.copyWith(status: SoundStatus.loading));
    try {
      final turnedOn = await gameRepository.isSoundOn();
      emit(
        state.copyWith(
          status: SoundStatus.success,
          turnedOn: turnedOn,
        ),
      );
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print(stacktrace);
      }
      emit(state.copyWith(status: SoundStatus.error));
    }
  }

  void _mapSelectSoundEventToState(
      SelectSound event, Emitter<SoundState> emit) async {
    await gameRepository.setSoundOn(event.turnedOn);
    emit(
      state.copyWith(
        status: SoundStatus.selected,
        turnedOn: event.turnedOn,
      ),
    );
  }
}
