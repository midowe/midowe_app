import 'package:midowe_app/models/campaign_data.dart';

class Category {
  final int id;
  final String name;
  final String description;
  final String createdAt;
  final String updatedAt;

  final List<CampaignData> campaigns;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.campaigns,
  });

  factory Category.fromJson(
      Map<String, dynamic> json, int id, List<CampaignData> campaigns) {
    return Category(
      id: id,
      name: json['name'] == null ? "" : json['name'],
      description: json['description'] == null ? "" : json['description'],
      createdAt: json['createdAt'] == null ? "" : json['createdAt'],
      updatedAt: json['updatedAt'] == null ? "" : json['updatedAt'],
      campaigns: campaigns,
    );
  }
}
