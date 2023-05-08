import 'package:flappy_game/features/game/data/entities/leaderboard.dart';
import 'package:flappy_game/features/menu/data/entities/apiresponse.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../config/api_constants.dart';
import '../../repository/game_repository.dart';

class GameRepositoryImpl extends GameRepository {
  @override
  Future<ApiResponse> updateUserRecord(int record) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? uuid = prefs.getString('uuid');

    var url = Uri.parse(baseUrl + updateRecord);

    var result = await http.post(url, headers: {
      'Accept': 'application/json',
    }, body: {
      'UniqueId': uuid,
      'Record': '$record',
    });

    if (result.statusCode == 200) {
      prefs.setInt('record', record);
    }

    return ApiResponse(statusCode: result.statusCode, response: result.body);
  }

  @override
  Future<List<Leaderboard>> getTimeLeaderboard() async {
    var url = Uri.parse(baseUrl + timeLeaderboard);

    var leaderboard = await http.get(url, headers: {
      'Accept': 'application/json',
    });

    return leaderboardFromJson(leaderboard.body);
  }

  @override
  Future<int> initGame() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? record = prefs.getInt('record');

    return record ?? 0;
  }
}
