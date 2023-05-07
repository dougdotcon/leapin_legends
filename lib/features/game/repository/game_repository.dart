import '../../menu/data/entities/user.dart';

abstract class GameRepository {
  Future<void> updateUserRecord(int record);
  Future<List<User>> getTimeLeaderboard();
  Future<int> initGame();
}
