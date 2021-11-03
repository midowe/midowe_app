import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:midowe_app/models/campaign_model.dart';
import 'package:midowe_app/views/campaign_profile/campaign_header.dart';

import 'campaign_content.dart';
import 'campaign_donations.dart';
import 'campaign_stats.dart';

class CampaignProfile extends StatelessWidget {
  final Campaign campaign;
  final Widget actionArea;

  const CampaignProfile({
    required this.campaign,
    required this.actionArea,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CampaignHeader(
          campaign: this.campaign,
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
