import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../models/CampaignData.dart';
import '../../models/donation_model.dart';
import '../../providers/campaign_provider.dart';

class CampaignDonations extends StatelessWidget {
  final CampaignData campaign;

  const CampaignDonations({required this.campaign});

  @override
  Widget build(BuildContext context) {
    final campaignProvider = GetIt.I.get<CampaignProvider>();
    late Future<List<CampaignData>> campaigns;
    Future<List<Donation>> donations =
        campaignProvider.fetchDonationsByCampagn(campaign.id);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 35,
          ),
          Text(
            "Doações recebidas",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
          SizedBox(
            height: 5,
          ),
          FutureBuilder<List<Donation>>(
              future: donations,
              builder: (context, snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  children = <Widget>[
                    SizedBox(width: 15),
                    for (var donation in snapshot.data!)
                      ListTile(
                        title: Text(donation.donor_name),
                        subtitle: Text(donation.amount.toString() +
                            " MT - " +
                            donation.createdAt),
                      ),
                  ];
                } else if (snapshot.hasError) {
                  children = <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    )
                  ];
                } else {
                  children = const <Widget>[
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text(
                          "Nenhuma doação recebida até agora",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ))
                  ];
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: children,
                  ),
                );
              }),
        ],
      ),
    );
  }
}
