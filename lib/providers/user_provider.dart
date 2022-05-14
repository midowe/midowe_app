import 'dart:convert';

import 'package:midowe_app/models/user_model.dart';
import 'package:midowe_app/providers/base_provider.dart';

class UserProvider extends BaseProvider {
  Future<User> fetchUserById(String? userId) async {
    return User(
        name: 'Dias Admin',
        headline: 'Software Developer',
        picture: 'https://picsum.photos/200');
  }
}
