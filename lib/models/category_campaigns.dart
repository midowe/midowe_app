import 'package:midowe_app/models/campaign_model.dart';
import 'package:midowe_app/models/category_model.dart';

class CategoryCampaigns {
  final Category category;
  final List<Campaign> campaigns;

  CategoryCampaigns({required this.category, required this.campaigns});

  factory CategoryCampaigns.fromJson(Map<String, dynamic> json) {
    return CategoryCampaigns(
      category: Category.fromJson(json['category']),
      campaigns:
          (json['campaigns'] as List).map((i) => Campaign.fromJson(i)).toList(),
    );
  }
}
