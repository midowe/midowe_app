
import 'CampaignImage.dart';
import 'Fundraiser.dart';

class CampaignData {
  late int id;
  late String title;
  late String description;
  late num target_amount;
  late String target_date;
  late  bool verified;
  late bool approved;
  late bool on_spot;
  late String verified_at;
  late String verified_by;
  late String thank_you_message;
  late String createdAt;
  late String updatedAt;
  late int total_donations;
  late var total_amount;
  late num current_balance;
  late String notes;
  late String url;
  late List<CampaignImage>? images;
  late Fundraiser? fundraiser;

  CampaignData({
    required this.id,
    required this.description,
    required this.title,
    required this.target_date,
    required this.verified,
    required this.on_spot,
    required this.verified_at,
    required this.verified_by,
    required this.approved,
    required this.target_amount,
    required  this.thank_you_message,
    required  this.total_donations,
    required  this.total_amount,
    required  this.current_balance,
    required  this.notes,
    required  this.updatedAt,
    required  this.createdAt ,
    required this.url,
     this.images,
     this.fundraiser,

  });

  factory CampaignData.fromJson(Map<String, dynamic> json,  int id, String url, Fundraiser fundraiser, List<CampaignImage> images) {
    return CampaignData(
      id: id,
      description: json['description'],
      title: json['title'],
      target_date: json['target_date']==null? "":json['target_date'],
      verified: json['verified']==null? false: json['verified'],
      on_spot: json['on_spot'] ==null? false: json['on_spot'],
      target_amount: json['target_amount'] ==null? 0.00: json['target_amount'],
      verified_at: json['verified_at']==null? "": json['verified_at'],
      verified_by: json['verified_by'] ==null? "": json['verified_by'],
      approved: json['approved'] ==null? false: json['approved'],
      thank_you_message: json['thank_you_message'] ==null? "": json['thank_you_message'],
      total_donations: json['total_donations'] ==null? 0: json['total_donations'],
      total_amount: json['total_amount'] ==null? 0.00: json['total_amount'],
      current_balance: json['current_balance'] ==null? 0.00: json['current_balance'],
      notes: json['notes'] ==null? "": json['notes'],
      updatedAt: json['updatedAt'] ==null? "": json['updatedAt'],
      createdAt: json['createdAt'] ==null? "": json['createdAt'],
      url: url,
      fundraiser: fundraiser,
      images: images
    );

  }

  factory CampaignData.fromJson2(Map<String, dynamic> json,  int id, String url) {
    return CampaignData(
        id: id,
        description: json['description'],
        title: json['title'],
        target_date: json['target_date']==null? "":json['target_date'],
        verified: json['verified']==null? false: json['verified'],
        on_spot: json['on_spot'] ==null? false: json['on_spot'],
        target_amount: json['target_amount'] ==null? 0.00: json['target_amount'],
        verified_at: json['verified_at']==null? "": json['verified_at'],
        verified_by: json['verified_by'] ==null? "": json['verified_by'],
        approved: json['approved'] ==null? false: json['approved'],
        thank_you_message: json['thank_you_message'] ==null? "": json['thank_you_message'],
        total_donations: json['total_donations'] ==null? 0: json['total_donations'],
        total_amount: json['total_amount'] ==null? 0.00: json['total_amount'],
        current_balance: json['current_balance'] ==null? 0: json['current_balance'],
        notes: json['notes'] ==null? "": json['notes'],
        updatedAt: json['updatedAt'] ==null? "": json['updatedAt'],
        createdAt: json['createdAt'] ==null? "": json['createdAt'],
        url: url,
    );

  }



}
