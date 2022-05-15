import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:midowe_app/models/user_model.dart';
import 'package:midowe_app/providers/fundraiser_provider.dart';

import '../../models/Fundraiser.dart';

class CampaignAuthor extends StatefulWidget {
  final int campaignId;

  const CampaignAuthor({Key? key,  required this.campaignId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CampaignAuthorState();
  }
}

class _CampaignAuthorState extends State<CampaignAuthor> {
  final fundraiserProvider = GetIt.I.get<FundraiserProvider>();
  late Future<Fundraiser>? fundraiser;

  @override
  void initState() {
    super.initState();
    this.fundraiser = fundraiserProvider.fetchFundraiserByCampaignId(widget.campaignId) as Future<Fundraiser>?;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Fundraiser>(
      future: fundraiser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: Row(
              children: [
                CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(snapshot.data!.picture)),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.data!.full_name,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(snapshot.data!.headline),
                  ],
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return CircularProgressIndicator();
      },
    );
  }
}
