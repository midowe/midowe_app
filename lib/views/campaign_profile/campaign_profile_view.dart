import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:midowe_app/models/CampaignData.dart';
import 'package:midowe_app/models/category_model.dart';
import 'package:midowe_app/utils/constants.dart';
import 'package:midowe_app/views/campaign_donate/campaign_donate_view.dart';
import 'package:midowe_app/views/campaign_profile/campaign_profile.dart';
import 'package:midowe_app/widgets/thank_you_dialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share_plus/share_plus.dart';

class CampaignProfileView extends StatelessWidget {
  final CampaignData campaign;
  final Category? category;

  const CampaignProfileView({Key? key, required this.campaign, this.category})
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
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.leftToRightWithFade,
                            child: CampaignDonateView(
                              campaign: campaign,
                            ),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Constants.primaryColor,
                        primary: Colors.white,
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
                          backgroundColor: Constants.primaryBackGround,
                          primary: Constants.primaryBackGround,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          side: BorderSide(
                              color: Constants.primaryColor,
                              width: 2.0,
                              style: BorderStyle.solid),
                        ),
                        child: Icon(
                          FontAwesomeIcons.shareAlt,
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
      await Share.share(campaign.url,
          subject: campaign.title,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Container(
            height: 430,
            child: ThankYouDialogBox(
                amount: "100MT",
                paymentMethod: "M-Pesa",
                userPhone: "842058817",
                userName: "Américo Chaquisse"),
          ),
        );
      },
    );
  }
}
