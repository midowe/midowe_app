import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:midowe_app/models/campaign_model.dart';
import 'package:midowe_app/utils/helper.dart';
import 'package:midowe_app/views/campaign_donate_view.dart';
import 'package:midowe_app/widgets/campaign_profile.dart';
import 'package:midowe_app/widgets/primary_button_icon.dart';
import 'package:midowe_app/widgets/thank_you_dialog.dart';

class CampaignProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Future.delayed(Duration.zero, () => _showSuccessDialog(context));

    return Scaffold(
      body: SingleChildScrollView(
        child: CampaignProfile(
          campaignModel: CampaignModel(),
          actionArea: SizedBox(
            width: 200,
            child: PrimaryButtonIcon(
              text: "Fazer doação",
              icon: Icon(CupertinoIcons.heart),
              onPressed: () {
                Helper.nextPage(context, CampaignDonateView());
              },
            ),
          ),
        ),
      ),
    );
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
