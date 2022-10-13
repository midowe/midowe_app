import 'package:midowe_app/models/featured_campaign.dart';
import 'package:midowe_app/models/campaign_model.dart';
import 'package:midowe_app/models/category_model.dart';

class CategoryCampaigns {
  final Category category;
  final List<Campaign> campaigns;
  final List<FeaturedCampaign> campaignsList = [];

  CategoryCampaigns({required this.category, required this.campaigns});

  factory CategoryCampaigns.fromJson(Map<String, dynamic> json) {
    return CategoryCampaigns(
      category: Category.fromJson(json['category'], 1, []),
      campaigns:
          (json['campaigns'] as List).map((i) => Campaign.fromJson(i)).toList(),
    );
  }
}
