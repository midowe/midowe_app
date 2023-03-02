import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:midowe_app/components/campaign_profile.dart';
import 'package:midowe_app/helpers/constants.dart';
import 'package:midowe_app/helpers/router_helper.dart';
import 'package:midowe_app/models/campaign_data.dart';
import 'package:midowe_app/models/category_model.dart';
import 'package:midowe_app/screens/campaign_donate_screen.dart';
import 'package:share_plus/share_plus.dart';

class CampaignProfileScreen extends StatelessWidget {
  final CampaignData campaign;
  final Category? category;

  const CampaignProfileScreen({Key? key, required this.campaign, this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Future.delayed(Duration.zero, () => _showSuccessDialog(context));

    return Scaffold(
        body: SingleChildScrollView(
            child: CampaignProfile(
                campaign: campaign,
                category: category,
                actionArea: Row(children: [
                  ElevatedButton(
                      onPressed: () {
                        RouterHelper.nextPage(
                            context,
                            CampaignDonateScreen(
                              campaign: campaign,
                            ));
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Constants.primaryColor,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "APOIAR",
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.white),
                          ),
                          SizedBox(width: 15),
                          Icon(FontAwesomeIcons.heart)
                        ],
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  if (campaign.verified)
                    TextButton(
                        onPressed: () => _onShare(context, campaign),
                        style: TextButton.styleFrom(
                          foregroundColor: Constants.primaryBackGround,
                          backgroundColor: Constants.primaryBackGround,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          side: BorderSide(
                              color: Constants.primaryColor,
                              width: 2.0,
                              style: BorderStyle.solid),
                        ),
                        child: Icon(
                          FontAwesomeIcons.shareNodes,
                          color: Constants.primaryColor,
                        )),
                ]))));
  }

  void _onShare(BuildContext context, CampaignData campaign) async {
    // A builder is used to retrieve the context immediately
    // surrounding the ElevatedButton.
    //
    // The context's `findRenderObject` returns the first
    // RenderObject in its descendent tree when it's not
    // a RenderObjectWidget. The ElevatedButton's RenderObject
    // has its position and size after it's built.
    final box = context.findRenderObject() as RenderBox?;

    {
      await Share.share("${Constants.BASE_URL_WEB}${campaign.url}",
          subject: campaign.title,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }
  }
}
