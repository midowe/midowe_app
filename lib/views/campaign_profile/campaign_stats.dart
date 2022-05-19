import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:midowe_app/models/campaign_model.dart';
import 'package:midowe_app/utils/constants.dart';
import 'package:midowe_app/utils/formatter.dart';

import '../../models/CampaignData.dart';

class CampaignStats extends StatelessWidget {
  final CampaignData campaign;

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
              Text(
                "${campaign.total_donations} apoiantes (${Formatter.currencyDouble((campaign.current_balance.toDouble()*100)/campaign.target_amount.toDouble())}%) - Meta ${Formatter.currencyDouble(campaign.target_amount.toDouble())}  termina ${campaign.target_date}",
                style: TextStyle(color: Constants.secondaryColor2),
              ),
            ],
          )),
          if (campaign.target_date != '')
            Icon(
              FontAwesomeIcons.calendarAlt,
              size: 18,
            ),
          if (campaign.target_date != '')
            Text(
              "${Formatter.dayMonth(campaign.target_date)}",
              style: TextStyle(color: Constants.primaryColor),
            )
        ],
      ),
    );
  }
}
