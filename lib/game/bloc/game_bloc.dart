import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/game_repository.dart';
import 'bloc_event.dart';
import 'bloc_state.dart';

class GameModelBloc extends Bloc<GameModelEvent, GameModelState> {
  GameModelBloc({
    required this.gameRepository,
  }) : super(const GameModelState()) {
    on<GetGameModel>(_mapGetGameModelEventToState);
    on<UpdateGameModel>(_mapUpdateGameModelEventToState);
    on<ResetGameModel>(_mapResetGameModelEventToState);
    on<OnCellTapped>(_mapOnCellTappedEventToState);
  }

  final GameRepository gameRepository;

  void _mapGetGameModelEventToState(
      GetGameModel event, Emitter<GameModelState> emit) async {
    emit(state.copyWith(status: GameModelStatus.loading));
    try {
      final gameModel = await gameRepository.provideGameModel();
      emit(
        state.copyWith(
          status: GameModelStatus.success,
          gameModel: gameModel,
        ),
      );
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print(stacktrace);
      }
      emit(state.copyWith(status: GameModelStatus.error));
    }
  }

  void _mapUpdateGameModelEventToState(
      UpdateGameModel event, Emitter<GameModelState> emit) async {
    final gameModel = await gameRepository.provideGameModel();
    emit(
      state.copyWith(
        status: GameModelStatus.success,
        gameModel: gameModel,
      ),
    );
  }

  void _mapResetGameModelEventToState(
      ResetGameModel event, Emitter<GameModelState> emit) async {
    final gameModel = gameRepository.resetGameModel();
    emit(
      state.copyWith(
        status: GameModelStatus.success,
        gameModel: gameModel,
      ),
    );
  }

  void _mapOnCellTappedEventToState(
      OnCellTapped event, Emitter<GameModelState> emit) async {
    final gameModel = gameRepository.onCellTapped(event.point);
    emit(
      state.copyWith(
        status: GameModelStatus.success,
        gameModel: gameModel,
      ),
    );
    await Future.delayed(const Duration(milliseconds: 300));
    final gameModel2 = gameRepository.opponentMove();
    emit(
      state.copyWith(
        status: GameModelStatus.success,
        gameModel: gameModel2,
      ),
    );
  }
}
