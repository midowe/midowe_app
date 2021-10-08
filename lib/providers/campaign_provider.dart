import 'dart:convert';

import 'package:midowe_app/models/campaign_model.dart';
import 'package:midowe_app/providers/base_provider.dart';

class CampaignProvider extends BaseProvider {
  Future<List<Campaign>> fetchFeatured() async {
    final response = await get(
        "/campaigns?featured=true&_sort=published_at:DESC&approved=true");

    if (response.statusCode == 200) {
      final campaings = (jsonDecode(response.body) as List)
          .map((i) => Campaign.fromJson(i))
          .toList();
      return campaings;
    } else {
      throw Exception(
          "Failed to fetch featured campaigns. Error ${response.statusCode}");
    }
  }

  Future<List<Campaign>> fetchTopOfCategory(int categoryId) async {
    final response = await get(
        "/campaigns?category=$categoryId&_sort=published_at:DESC&approved=true&_limit=2");

    if (response.statusCode == 200) {
      final campaings = (jsonDecode(response.body) as List)
          .map((i) => Campaign.fromJson(i))
          .toList();
      return campaings;
    } else {
      throw Exception(
          "Failed to fetch top campaigns of category $categoryId. Error ${response.statusCode}");
    }
  }

  Future<List<Campaign>> fetchOfCategory(
    int categoryId,
    int pageKey,
    int pageSize,
  ) async {
    print('Provider being called $categoryId, $pageKey, $pageSize');

    final response = await get(
        "/campaigns?category=$categoryId&_sort=published_at:DESC&approved=true&_start=$pageKey&_limit=$pageSize");

    if (response.statusCode == 200) {
      final campaings = (jsonDecode(response.body) as List)
          .map((i) => Campaign.fromJson(i))
          .toList();
      return campaings;
    } else {
      throw Exception(
          "Failed to fetch top campaigns of category $categoryId. Error ${response.statusCode}");
    }
  }
}
