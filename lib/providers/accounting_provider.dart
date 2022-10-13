import 'dart:convert';

import 'package:midowe_app/providers/base_provider.dart';

class AccountingProvider extends BaseProvider {
  Future<bool> registerDonation(
      String categoryId, String campaignId, Map<String, dynamic> body) async {
    final response =
        await accountingPost("/donations/$categoryId/$campaignId", body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['registered'];
    } else {
      throw Exception(
          "Failed to fetch statistics. Error ${response.statusCode}");
    }
  }
}
