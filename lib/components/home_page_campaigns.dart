import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:midowe_app/components/campaign_list_item.dart';
import 'package:midowe_app/components/title_subtitle_heading.dart';
import 'package:midowe_app/helpers/constants.dart';
import 'package:midowe_app/helpers/router_helper.dart';
import 'package:midowe_app/models/campaign_data.dart';
import 'package:midowe_app/screens/campaign_stats_screen.dart';

import '../providers/campaign_provider.dart';
import 'home_header.dart';

class HomePageCampaigns extends StatefulWidget {
  const HomePageCampaigns({Key? key}) : super(key: key);

  @override
  State<HomePageCampaigns> createState() => _HomePageCampaigns();
}

class _HomePageCampaigns extends State<HomePageCampaigns> {
  final campaignProvider = GetIt.I.get<CampaignProvider>();
  late Future<List<CampaignData>> fundraiserCampaigns;

  @override
  void initState() {
    super.initState();
    this.fundraiserCampaigns =
        campaignProvider.listCampaignsOfFundraiser(sessionUserSub);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
          HomeHeader(
            actionButton: TextButton(
              onPressed: () async {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(41, 40),
                alignment: Alignment.center,
                backgroundColor: Constants.secondaryColor4,
                foregroundColor: Constants.primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              child: Icon(
                Icons.add,
                color: Colors.black87,
              ),
            ),
          ),
          FutureBuilder<List<CampaignData>>(
            future: fundraiserCampaigns,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, top: 20.0, right: 20.0, bottom: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TitleSubtitleHeading(
                          "Campanhas",
                          "Veja como suas campanhas tem performado",
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        for (var campaign in snapshot.data!)
                          CampaignListItem(
                            campaign: campaign,
                            onPressed: () {
                              RouterHelper.nextPage(context,
                                  CampaignStatsScreen(campaign: campaign));
                            },
                          ),
                      ],
                    ));
              } else if (snapshot.hasError) {
                return Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Text('${snapshot.error}'),
                );
              }
              return const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: CircularProgressIndicator(),
                ),
              );
            },
          )
        ]));
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key, required this.user}) : super(key: key);

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (user.name != null) Text(user.name!),
        if (user.email != null) Text(user.email!)
      ],
    );
  }
}
