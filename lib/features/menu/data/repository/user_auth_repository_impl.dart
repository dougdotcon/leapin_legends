// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:vibration/vibration.dart';

import '../../../../config/api_constants.dart';
import '../../domain/user_auth_repository.dart';
import '../entities/apiresponse.dart';
import '../entities/user.dart';

class UserAuthRepositoryImpl extends UserAuthRepository {
  @override
  Future<User?> authUser() async {
    String? uniqueMobileId = await UniqueIdentifier.serial;
    var url = Uri.parse(baseUrl + verifyUser);

    var response = await http.post(url, body: {
      'UniqueId': uniqueMobileId,
    });

    if (response.statusCode == 200) {
      User userData = userFromJson(response.body);
      return User(
        uniqueId: userData.uniqueId,
        name: userData.name,
        record: userData.record,
        rank: userData.rank,
        taps: userData.taps,
      );
    } else {
      return null;
    }
  }

  @override
  Future<ApiResponse> addUser({required String name}) async {
    String? uniqueMobileId = await UniqueIdentifier.serial;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('uuid', uniqueMobileId!);

    var url = Uri.parse(baseUrl + addNewUser);

    var response = await http.post(url, body: {
      'UniqueId': uniqueMobileId,
      'Name': name,
    });

    return ApiResponse(statusCode: response.statusCode, response: response.body);
  }

  @override
  void errorVibration() {
    Vibration.vibrate(amplitude: 255, duration: 100);
  }
}
