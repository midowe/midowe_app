import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:midowe_app/helpers/constants.dart';

class AccountingProvider {
  Future<bool> registerDonation(
      String categoryId, String campaignId, Map<String, dynamic> body) async {
    final response = await http.post(
        Uri.parse(
            Constants.BASE_URL_CMS + "/donations/$categoryId/$campaignId"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['registered'];
    } else {
      throw Exception(
          "Failed to register donation. Error ${response.statusCode}");
    }
  }
}
