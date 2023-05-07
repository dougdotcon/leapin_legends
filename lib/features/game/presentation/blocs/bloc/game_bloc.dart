import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flappy_game/config/enums.dart';

import '../../../data/repository/game_repository_impl.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc()
      : super(const GameState(
          gameStatus: GameStatus.stoped,
          heroPosition: 0,
          isJumping: false,
          obstaclePositions: [],
          result: 0,
          difficulity: Difficulity.extreme,
          recordStatus: RecordStatus.notBroken,
          record: 0,
        )) {
    on<UpdateHeroPosition>(_onUpdateHeroPosition);
    on<UpdateObstaclePositions>(_onUpdateObstaclePositions);
    on<CheckColission>(_onCheckCollision);
    on<Jump>(_onJump);
    on<UpdateGameStatus>(_onUpdateGameStatus);
    on<InitNewGame>(_onInitNewGame);
    on<ChangeDifficulity>(_changeDifficulity);
    on<UpdateUserRecord>(_updateUserRecord);
    on<GetLeaderBoard>(_getLederboard);
    on<InitGame>(_initGame);
  }

  void _onUpdateHeroPosition(UpdateHeroPosition event, Emitter<GameState> emit) {
    if (state.isJumping) {
      final updatedHeroPosition = state.heroPosition + 2;
      emit(state.copyWith(heroPosition: updatedHeroPosition));
      if (updatedHeroPosition >= 50) {
        emit(state.copyWith(isJumping: false));
      }
    } else if (state.heroPosition > 0) {
      emit(state.copyWith(heroPosition: state.heroPosition - 2));
    }
  }

  void _onUpdateObstaclePositions(UpdateObstaclePositions event, Emitter<GameState> emit) {
    if (state.gameStatus != GameStatus.started) {
      return;
    }

    var updatedObstaclePositions = state.obstaclePositions.map((position) => position - 2).toList(growable: false);

    var distance = 1000;

    switch (state.difficulity) {
      case Difficulity.medium:
        distance = 900;
        break;
      case Difficulity.hard:
        distance = 800;
        break;
      case Difficulity.extreme:
        distance = 700;
        break;
      default:
    }

    if (state.obstaclePositions.isEmpty || state.obstaclePositions.last < 400) {
      final position = distance / 1.5 + math.Random().nextDouble() * distance / 2;
      updatedObstaclePositions = [
        ...state.obstaclePositions,
        position,
      ];
    }
    emit(state.copyWith(obstaclePositions: updatedObstaclePositions, result: state.result + 0.1));
  }

  void _onCheckCollision(CheckColission event, Emitter<GameState> emit) {
    for (final obstaclePosition in state.obstaclePositions) {
      if (obstaclePosition < 75 && obstaclePosition + 20 > 80 && state.heroPosition + 20 < 50) {
        emit(state.copyWith(gameStatus: GameStatus.lose));
      }
    }
  }

  void _onJump(Jump event, Emitter<GameState> emit) {
    emit(state.copyWith(isJumping: true));
    add(UpdateHeroPosition());
  }

  void _onUpdateGameStatus(UpdateGameStatus event, Emitter<GameState> emit) {
    emit(state.copyWith(gameStatus: event.gameStatus));
  }

  void _onInitNewGame(InitNewGame event, Emitter<GameState> emit) {
    emit(state.copyWith(obstaclePositions: [], result: 0));
  }

  void _getLederboard(GetLeaderBoard event, Emitter<GameState> emit) {}

  void _updateUserRecord(UpdateUserRecord event, Emitter<GameState> emit) async {
    var newRecord = await GameRepositoryImpl().updateUserRecord(event.record);

    if (newRecord.statusCode == 200) {
      emit(state.copyWith(recordStatus: RecordStatus.newRecord, record: event.record));
      return;
    }
    emit(state.copyWith(recordStatus: RecordStatus.notBroken));
  }

  void _changeDifficulity(ChangeDifficulity event, Emitter<GameState> emit) {
    var difficulity = state.difficulity;
    switch (difficulity) {
      case Difficulity.easy:
        difficulity = Difficulity.medium;
        break;
      case Difficulity.medium:
        difficulity = Difficulity.hard;
        break;
      default:
    }
    emit(state.copyWith(difficulity: difficulity));
  }

  void _initGame(InitGame event, Emitter<GameState> emit) async {
    var actualRecord = await GameRepositoryImpl().initGame();
    emit(state.copyWith(record: actualRecord));
  }
}
