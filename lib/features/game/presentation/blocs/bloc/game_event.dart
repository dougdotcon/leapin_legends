// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'game_bloc.dart';

abstract class GameEvent {}

class UpdateHeroPosition extends GameEvent {}

class UpdateObstaclePositions extends GameEvent {}

class CheckColission extends GameEvent {}

class UpdateGameStatus extends GameEvent {
  final GameStatus gameStatus;
  UpdateGameStatus({
    required this.gameStatus,
  });
}

class Jump extends GameEvent {}

class InitNewGame extends GameEvent {}

class ChangeDifficulity extends GameEvent {}
