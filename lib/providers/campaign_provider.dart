import 'dart:convert';

import 'package:midowe_app/models/campaign_model.dart';
import 'package:midowe_app/providers/base_provider.dart';

class CampaignProvider extends BaseProvider {
  Future<List<Campaign>> fetchFeatured() async {
    final response = await cmsGet(
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
    final response = await cmsGet(
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
    final response = await cmsGet(
        "/campaigns?category=$categoryId&_sort=published_at:DESC&approved=true&_start=$pageKey&_limit=$pageSize");

    if (response.statusCode == 200) {
      final campaings = (jsonDecode(response.body) as List)
          .map((i) => Campaign.fromJson(i))
          .toList();
      return campaings;
    } else {
      throw Exception(
          "Failed to fetch campaigns of category $categoryId. Error ${response.statusCode}");
    }
  }

  Future<List<Campaign>> fetchPendingApproval(
    int pageKey,
    int pageSize,
  ) async {
    final response = await cmsGet(
        "/campaigns?_sort=created_at:DESC&approved=false&_start=$pageKey&_limit=$pageSize");

    if (response.statusCode == 200) {
      final campaings = (jsonDecode(response.body) as List)
          .map((i) => Campaign.fromJson(i))
          .toList();
      return campaings;
    } else {
      throw Exception(
          "Failed to fetch pending approval campaigns. Error ${response.statusCode}");
    }
  }

  Future<List<Campaign>> fetchSearchCampaign(
    String keyword,
    int pageKey,
    int pageSize,
  ) async {
    if (keyword.isEmpty) {
      return List.empty();
    }

    final response = await cmsGet(
        "/campaigns?_sort=created_at:DESC&approved=true&title_contains=$keyword&_start=$pageKey&_limit=$pageSize");

    if (response.statusCode == 200) {
      final campaings = (jsonDecode(response.body) as List)
          .map((i) => Campaign.fromJson(i))
          .toList();
      return campaings;
    } else {
      throw Exception(
          "Failed to fetch pending approval campaigns. Error ${response.statusCode}");
    }
  }

  Future<int> countPendingApproval() async {
    final response = await cmsGet("/campaigns/count?approved=false");

    if (response.statusCode == 200) {
      return int.parse(response.body);
    } else {
      throw Exception(
          "Failed to count pending approval campaigns. Error ${response.statusCode}");
    }
  }
}
