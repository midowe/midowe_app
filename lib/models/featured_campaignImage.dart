class FeaturedCampaignImage {
  late String url;

  FeaturedCampaignImage({required this.url});

  factory FeaturedCampaignImage.fromJson(Map<String, dynamic> json) {
    return FeaturedCampaignImage(url: json['url']);
  }
}
