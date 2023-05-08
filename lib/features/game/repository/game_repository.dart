import '../data/entities/leaderboard.dart';

abstract class GameRepository {
  Future<void> updateUserRecord(int record);
  Future<List<Leaderboard>> getTimeLeaderboard();
  Future<int> initGame();
}
