import 'dart:convert';

User userFromJson(String str) {
  final jsonData = json.decode(str);
  return User.fromJson(jsonData);
}

class User {
  String uniqueId;
  String name;
  int? record;
  int? rank;
  int? taps;

  User({
    required this.uniqueId,
    required this.name,
    required this.record,
    required this.rank,
    required this.taps,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        uniqueId: json["uniqueId"],
        name: json["name"],
        record: json["record"],
        rank: json["rank"] ?? 0,
        taps: json["taps"] ?? 0,
      );
}
