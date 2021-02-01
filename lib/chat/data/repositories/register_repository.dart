import 'dart:convert';

import 'package:blogapp/chat/data/models/custom_error.dart';
import 'package:blogapp/chat/data/models/user.dart';
import 'package:blogapp/chat/utils/custom_http_client.dart';
import 'package:blogapp/chat/utils/custom_shared_preferences.dart';
import 'package:blogapp/chat/utils/my_urls.dart';

class RegisterRepository {
  CustomHttpClient http = CustomHttpClient();

  Future<dynamic> register(
      String name,
      String username,
      String password,
      String company,
      String email,
      String phone,
      String age,
      String domicile) async {
    try {
      var body = jsonEncode({
        'name': name,
        'username': username,
        'password': password,
        'company': company,
        'email': email,
        'phone': phone,
        'age': age,
        'domicile': domicile
      });
      var response = await http.post(
        '${MyUrls.serverUrl}/user',
        body: body,
      );
      final dynamic registerResponse = jsonDecode(response.body);
      await CustomSharedPreferences.setString(
          'token', registerResponse['token']);

      if (registerResponse['error'] != null) {
        return CustomError.fromJson(registerResponse);
      }

      final User user = User.fromJson(registerResponse['user']);
      return user;
    } catch (err) {
      throw err;
    }
  }
}
