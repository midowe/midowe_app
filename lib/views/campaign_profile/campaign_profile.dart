import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:midowe_app/models/category_model.dart';
import 'package:midowe_app/views/campaign_profile/campaign_header.dart';

import '../../models/CampaignData.dart';
import 'campaign_content.dart';
import 'campaign_donations.dart';
import 'campaign_stats.dart';

class CampaignProfile extends StatelessWidget {
  final CampaignData campaign;
  final Widget actionArea;
  final Category? category;

  const CampaignProfile(
      {required this.campaign, required this.actionArea, this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CampaignHeader(
          campaign: this.campaign,
          category: this.category,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: actionArea,
        ),
        CampaignStats(
          campaign: campaign,
        ),
        CampaignContent(
          campaign: this.campaign,
        ),
        CampaignDonations(),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
