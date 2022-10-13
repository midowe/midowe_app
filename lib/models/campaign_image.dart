class CampaignImage {
  late String url;

  CampaignImage({required this.url});

  factory CampaignImage.fromJson(Map<String, dynamic> json) {
    return CampaignImage(url: json['url'] == null ? "" : json['url']);
  }
}
