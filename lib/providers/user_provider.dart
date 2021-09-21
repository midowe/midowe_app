import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:midowe_app/providers/base_provider.dart';

class UserProvider extends BaseProvider {
  Future<int> login(String identifier, String password) async {
    http.Response response = await post(
      "/auth/local",
      jsonEncode(
        <String, String>{'identifier': identifier, 'password': password},
      ),
    );

    Map<String, dynamic> decodedResponse = jsonDecode(response.body);

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

  //todo: logout, isAuth

}
