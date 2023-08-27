import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/game_repository.dart';
import 'bloc_event.dart';
import 'bloc_state.dart';

class SettingsWhoFirstBloc extends Bloc<SettingsWhoFirstEvent, WhoFirstState> {
  SettingsWhoFirstBloc({
    required this.gameRepository,
  }) : super(const WhoFirstState()) {
    on<GetWhoFirst>(_mapGetWhoFirstEventToState);
    on<SelectWhoFirst>(_mapSelectWhoFirstEventToState);
  }

  final GameRepository gameRepository;

  void _mapGetWhoFirstEventToState(
      GetWhoFirst event, Emitter<WhoFirstState> emit) async {
    emit(state.copyWith(status: WhoFirstStatus.loading));
    try {
      final whoFirst = await gameRepository.whosTurnBeFirst();
      emit(
        state.copyWith(
          status: WhoFirstStatus.success,
          who: whoFirst,
        ),
      );
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print(stacktrace);
      }
      emit(state.copyWith(status: WhoFirstStatus.error));
    }
  }

  void _mapSelectWhoFirstEventToState(
      SelectWhoFirst event, Emitter<WhoFirstState> emit) async {
    await gameRepository.setWhosTurnBeFirst(event.who);
    emit(
      state.copyWith(
        status: WhoFirstStatus.selected,
        who: event.who,
      ),
    );
  }
}
