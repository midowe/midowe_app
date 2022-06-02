import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:midowe_app/models/CampaignData.dart';
import 'package:midowe_app/models/category_model.dart';
import 'package:midowe_app/utils/constants.dart';
import 'package:midowe_app/utils/helper.dart';
import 'package:midowe_app/views/campaign_donate/campaign_donate_view.dart';
import 'package:midowe_app/views/campaign_profile/campaign_profile.dart';
import 'package:midowe_app/widgets/thank_you_dialog.dart';

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
                        Helper.nextPage(
                            context,
                            CampaignDonateView(
                              campaign: campaign,
                            ));
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Constants.primaryColor,
                        primary: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Apoiar",
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
                    ElevatedButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          primary: Colors.white,
                          padding: EdgeInsets.all(12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        child: Icon(
                          FontAwesomeIcons.shareAlt,
                          color: Constants.primaryColor,
                        )),
                ]))));
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
