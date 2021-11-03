class Campaign {
  final String categoryId;
  final String campaignId;
  final String userId;
  final String title;
  final String content;
  final String profileImage;
  final List<String> additionalImages;
  final int targetAmount;
  final String targetDate;
  final bool approved;
  final String approvedBy;
  final String approvedAt;
  final String createdAt;

  Campaign({
    required this.categoryId,
    required this.campaignId,
    required this.userId,
    required this.title,
    required this.content,
    required this.profileImage,
    required this.additionalImages,
    required this.targetAmount,
    required this.targetDate,
    required this.approved,
    required this.approvedBy,
    required this.approvedAt,
    required this.createdAt,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      categoryId: json['categoryId'],
      campaignId: json['campaignId'],
      userId: json['userId'],
      title: json['title'],
      content: json['content'],
      profileImage: json['profileImage'],
      additionalImages: json['additionalImages'].cast<String>(),
      targetAmount: int.parse(json['targetAmount']),
      targetDate: json['targetDate'],
      approved: json['approved'],
      approvedBy: json['approvedBy'],
      approvedAt: json['approvedAt'],
      createdAt: json['createdAt'],
    );
  }
}
