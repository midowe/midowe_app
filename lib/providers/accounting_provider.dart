import 'dart:convert';

import 'package:midowe_app/models/statistics_model.dart';
import 'package:midowe_app/providers/base_provider.dart';

class AccountingProvider extends BaseProvider {
  Future<Statistics> getStatistics(String campaignSlug) async {
    final response =
        await accountingGet("/statistics?campaignSlug=$campaignSlug");

    if (response.statusCode == 200) {
      return Statistics.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
          "Failed to fetch statistics. Error ${response.statusCode}");
    }
  }
}
