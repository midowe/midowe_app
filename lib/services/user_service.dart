import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:midowe_app/providers/user_provider.dart';

class UserService {
  final _userProvider = GetIt.I.get<UserProvider>();

  Future<AuthResponse> login(String identifier, String password) async {
    Response httpResponse = await _userProvider.login(identifier, password);

    AuthResponse authResponse =
        new AuthResponse(httpResponse.statusCode == 200);

    Map<String, dynamic> decodedResponse = jsonDecode(httpResponse.body);
    authResponse.messages.addAll(_retreviewMessages(decodedResponse));

    if (authResponse.success) {
      _persistTokenAndUserData(decodedResponse);
    }

    return authResponse;
  }

  Future<AuthResponse> register(
      String fullName, String phone, String email, String password) async {
    Response httpResponse =
        await _userProvider.register(fullName, phone, email, password);

    AuthResponse authResponse =
        new AuthResponse(httpResponse.statusCode == 200);

    Map<String, dynamic> decodedResponse = jsonDecode(httpResponse.body);
    authResponse.messages.addAll(_retreviewMessages(decodedResponse));

    if (authResponse.success) {
      _persistTokenAndUserData(decodedResponse);
    }

    return authResponse;
  }

  void _persistTokenAndUserData(Map<String, dynamic> decodedResponse) {
    //persist token and user data
  }

  List<String> _retreviewMessages(Map<String, dynamic> decodedResponse) {
    var messages = <String>[];
    if (decodedResponse.containsKey('message')) {
      for (var messageList in decodedResponse['message']) {
        for (var messageItem in messageList['messages']) {
          messages.add(messageItem['id'].toString());
        }
      }
    }
    return messages;
  }
}

class AuthResponse {
  bool success = false;
  List<String> messages = <String>[];

  AuthResponse(this.success);
}
