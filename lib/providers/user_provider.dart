import 'dart:convert';

import 'package:http/http.dart' as http;

class UserProvider {
  static final int RESPONSE_SUCCESS = 1;

  static bool isAuthenticated() {
    return false;
  }

  static Future<int> login(String identifier, String password) async {
    http.Response response = await http.post(
        Uri.parse("https://api.midowe.co.mz/auth/local"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{'identifier': identifier, 'password': password}));

    print(response.body);
    print(response.statusCode);

    return 1;
  }

  static bool register(
    String fullName,
    String username,
    String email,
    String password,
  ) {
    return false;
  }

  static bool logout() {
    return false;
  }
}
