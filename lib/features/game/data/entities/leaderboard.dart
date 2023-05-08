import 'dart:convert';

List<Leaderboard> leaderboardFromJson(String str) {
  final jsonData = json.decode(str);
  return List<Leaderboard>.from(jsonData.map((x) => Leaderboard.fromJson(x)));
}

class Leaderboard {
  String name;
  int record;
  Leaderboard({
    required this.name,
    required this.record,
  });

  factory Leaderboard.fromJson(Map<String, dynamic> json) => Leaderboard(
        name: json["name"],
        record: json["record"],
      );
}
