import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:midowe_app/models/campaign_model.dart';
import 'package:midowe_app/models/statistics_model.dart';
import 'package:midowe_app/providers/accounting_provider.dart';
import 'package:midowe_app/utils/constants.dart';
import 'package:midowe_app/utils/formatter.dart';

class CampaignStats extends StatefulWidget {
  final Campaign campaign;

  const CampaignStats({Key? key, required this.campaign}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CampaignStatsState();
}

class _CampaignStatsState extends State<CampaignStats> {
  final accountingProvider = GetIt.I.get<AccountingProvider>();
  late Future<Statistics> statistics;

  @override
  void initState() {
    super.initState();
    this.statistics =
        accountingProvider.getStatistics(widget.campaign.campaignId);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: [
          Container(
            child: FutureBuilder<Statistics>(
              future: statistics,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: [
                      Icon(
                        FontAwesomeIcons.users,
                        size: 20,
                      ),
                      Text(
                        "${snapshot.data!.totalDonations}",
                        style: TextStyle(color: Constants.primaryColor),
                      ),
                      Icon(
                        FontAwesomeIcons.searchDollar,
                        size: 20,
                      ),
                      Text(
                        "${Formatter.currencyDouble(snapshot.data!.totalAmount)}  de ${Formatter.currency(widget.campaign.targetAmount)} MT",
                        style: TextStyle(color: Constants.primaryColor),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return Container(
                  width: 0,
                  height: 0,
                );
              },
            ),
          ),
          if (widget.campaign.targetDate != '')
            Icon(
              FontAwesomeIcons.calendarAlt,
              size: 18,
            ),
          if (widget.campaign.targetDate != '')
            Text(
              "${Formatter.dayMonth(widget.campaign.targetDate)}",
              style: TextStyle(color: Constants.primaryColor),
            )
        ],
      ),
    );
  }
}
