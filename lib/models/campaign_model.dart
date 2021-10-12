import 'package:midowe_app/models/category_model.dart';
import 'package:midowe_app/models/user_model.dart';
import 'package:midowe_app/providers/base_provider.dart';

class Campaign {
  final int id;
  final String slug;
  final String title;
  final String content;
  final int? targetAmount;
  final String? targetDate;
  final bool approved;
  final Category category;
  final User user;
  final String image;
  final List<String> additionalPictures;

  Campaign({
    required this.id,
    required this.slug,
    required this.title,
    required this.content,
    this.targetAmount,
    this.targetDate,
    required this.approved,
    required this.category,
    required this.user,
    required this.image,
    required this.additionalPictures,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      id: json['id'],
      slug: json['slug'],
      title: json['title'],
      content: json['content'] == null ? '' : json['content'],
      targetAmount: json['targetAmount'],
      targetDate: json['targetDate'],
      approved: json['approved'],
      category: Category.fromJson(json['category']),
      user: User.fromJson(json['user']),
      image: BaseProvider.cmsBaseUrl + json['image']['url'],
      additionalPictures: List.empty(),
    );
  }
}
