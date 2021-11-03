import 'dart:convert';

import 'package:midowe_app/models/user_model.dart';
import 'package:midowe_app/providers/base_provider.dart';

class UserProvider extends BaseProvider {
  Future<User> fetchUserById(String userId) async {
    final response = await authGet("/user/$userId");

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
          "Failed to fetch user of id: $userId. Error ${response.statusCode}");
    }
  }
}
