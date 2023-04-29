// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'game_bloc.dart';

class GameState extends Equatable {
  final double heroPosition;
  final bool isJumping;
  final GameStatus gameStatus;
  final List<double> obstaclePositions;
  final double result;

  const GameState({
    required this.heroPosition,
    required this.isJumping,
    required this.gameStatus,
    required this.obstaclePositions,
    required this.result,
  });

  @override
  List<Object> get props => [heroPosition, isJumping, gameStatus, obstaclePositions, result];

  GameState copyWith({
    double? heroPosition,
    bool? isJumping,
    GameStatus? gameStatus,
    List<double>? obstaclePositions,
    double? result,
  }) {
    return GameState(
      heroPosition: heroPosition ?? this.heroPosition,
      isJumping: isJumping ?? this.isJumping,
      gameStatus: gameStatus ?? this.gameStatus,
      obstaclePositions: obstaclePositions ?? this.obstaclePositions,
      result: result ?? this.result,
    );
  }
}
