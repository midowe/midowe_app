import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:midowe_app/models/campaign_model.dart';
import 'package:midowe_app/utils/constants.dart';
import 'package:midowe_app/utils/formatter.dart';

class CampaignStats extends StatelessWidget {
  final Campaign campaign;

  const CampaignStats({Key? key, required this.campaign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: [
          Container(
              child: Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: [
              Icon(
                FontAwesomeIcons.users,
                size: 20,
              ),
              Text(
                "${campaign.totalDonations}",
                style: TextStyle(color: Constants.primaryColor),
              ),
              Icon(
                FontAwesomeIcons.searchDollar,
                size: 20,
              ),
              Text(
                "${Formatter.currencyDouble(campaign.totalAmount)} MT de ${Formatter.currency(campaign.targetAmount)} MT",
                style: TextStyle(color: Constants.primaryColor),
              ),
            ],
          )),
          if (campaign.targetDate != '')
            Icon(
              FontAwesomeIcons.calendarAlt,
              size: 18,
            ),
          if (campaign.targetDate != '')
            Text(
              "${Formatter.dayMonth(campaign.targetDate)}",
              style: TextStyle(color: Constants.primaryColor),
            )
        ],
      ),
    );
  }
}
