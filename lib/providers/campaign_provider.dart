import 'dart:convert';

import 'package:midowe_app/models/campaign_model.dart';
import 'package:midowe_app/models/category_campaigns.dart';
import 'package:midowe_app/providers/base_provider.dart';

class CampaignProvider extends BaseProvider {
  Future<List<Campaign>> fetchFeatured() async {
    final response = await cmsGet("/campaigns/featured");

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

  Future<List<CategoryCampaigns>> fetchTopByCategory() async {
    final response = await cmsGet("/campaigns/top?perCategory=2");

    if (response.statusCode == 200) {
      final categoryCampaigns = (jsonDecode(response.body) as List)
          .map((i) => CategoryCampaigns.fromJson(i))
          .toList();

      return categoryCampaigns;
    } else {
      throw Exception(
          "Failed to fetch top campaigns by category. Error ${response.statusCode}");
    }
  }

  Future<List<Campaign>> fetchOfCategory(
    String categoryId,
    String lastCampaignId,
  ) async {
    final response = await cmsGet(
        "/campaigns/category/$categoryId?lastCampaignId=$lastCampaignId");

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
    String lastCategoryId,
    String lastCampaignId,
  ) async {
    final response = await cmsGet(
        "/campaigns/pending?lastCategoryId=$lastCategoryId&lastCampaignId=$lastCampaignId");

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
    //todo: review
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
    //todo: review
    final response = await cmsGet("/campaigns/count?approved=false");

    if (response.statusCode == 200) {
      return int.parse(response.body);
    } else {
      throw Exception(
          "Failed to count pending approval campaigns. Error ${response.statusCode}");
    }
  }
}
