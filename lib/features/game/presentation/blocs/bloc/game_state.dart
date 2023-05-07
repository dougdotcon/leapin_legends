// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'game_bloc.dart';

class GameState extends Equatable {
  final double heroPosition;
  final bool isJumping;
  final GameStatus gameStatus;
  final List<double> obstaclePositions;
  final double result;
  final Difficulity difficulity;
  final RecordStatus recordStatus;
  final int record;

  const GameState({
    required this.heroPosition,
    required this.isJumping,
    required this.gameStatus,
    required this.obstaclePositions,
    required this.result,
    required this.difficulity,
    required this.recordStatus,
    required this.record,
  });

  @override
  List<Object> get props => [
        heroPosition,
        isJumping,
        gameStatus,
        obstaclePositions,
        result,
        difficulity,
        recordStatus,
        record,
      ];

  GameState copyWith({
    double? heroPosition,
    bool? isJumping,
    GameStatus? gameStatus,
    List<double>? obstaclePositions,
    double? result,
    Difficulity? difficulity,
    RecordStatus? recordStatus,
    int? record,
  }) {
    return GameState(
      heroPosition: heroPosition ?? this.heroPosition,
      isJumping: isJumping ?? this.isJumping,
      gameStatus: gameStatus ?? this.gameStatus,
      obstaclePositions: obstaclePositions ?? this.obstaclePositions,
      result: result ?? this.result,
      difficulity: difficulity ?? this.difficulity,
      recordStatus: recordStatus ?? this.recordStatus,
      record: record ?? this.record,
    );
  }
}
