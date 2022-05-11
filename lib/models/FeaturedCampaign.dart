import 'FeaturedCampaignImage.dart';

class FeaturedCampaign {
  late String title;
  late String description;
  late String url;
  late int id;

  FeaturedCampaign( {
    required this.description,
    required  this.id,
    required  this.url,
    required this.title  });

  factory FeaturedCampaign.fromJson(Map<String, dynamic> json, int id ) {
    return FeaturedCampaign(
      description: json['description'] ==null? "":json['description'],
      title: json['title']  ==null? "":json['title'],
      url:'',
      id: id,
    );

  }


}
