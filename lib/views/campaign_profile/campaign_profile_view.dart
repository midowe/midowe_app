import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:midowe_app/models/CampaignData.dart';
import 'package:midowe_app/models/category_model.dart';
import 'package:midowe_app/utils/helper.dart';
import 'package:midowe_app/views/campaign_donate/campaign_donate_view.dart';
import 'package:midowe_app/views/campaign_profile/campaign_profile.dart';
import 'package:midowe_app/widgets/primary_button_icon.dart';
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
          actionArea: SizedBox(
            width: 200,
            child: PrimaryButtonIcon(
              text: "Apoiar",
              icon: Icon(CupertinoIcons.heart),
              onPressed: () {
                Helper.nextPage(
                    context,
                    CampaignDonateView(
                      campaign: campaign,
                    ));
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
