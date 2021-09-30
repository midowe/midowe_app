import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:midowe_app/providers/base_provider.dart';

class UserProvider extends BaseProvider {
  Future<http.Response> login(String identifier, String password) async {
    return await post(
      "/auth/local",
      jsonEncode(
        <String, String>{'identifier': identifier, 'password': password},
      ),
    );
  }

  Future<http.Response> register(
    String fullName,
    String phone,
    String email,
    String password,
  ) async {
    return await post(
      "/auth/local/register",
      jsonEncode(
        <String, String>{
          'fullName': fullName,
          'username': phone,
          'phone': phone,
          'email': email,
          'password': password
        },
      ),
    );
  }
}
