// Basic campaign data
// donations history
// View donation details
// Realocatios history
// View campaign profile

import 'package:flutter/material.dart';
import 'package:midowe_app/models/campaign_data.dart';

class CampaignStatsScreen extends StatelessWidget {
  final CampaignData campaign;

  const CampaignStatsScreen({Key? key, required this.campaign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Campaign stats"),
    );
  }
}
