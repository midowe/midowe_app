import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:midowe_app/models/campaign_model.dart';
import 'package:midowe_app/utils/constants.dart';
import 'package:midowe_app/views/campaign_profile/campaign_profile.dart';
import 'package:midowe_app/widgets/primary_button_icon.dart';
import 'package:midowe_app/widgets/primary_outline_button.dart';

class ApprovalProfileView extends StatelessWidget {
  final Campaign campaign;

  const ApprovalProfileView({Key? key, required this.campaign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: CampaignProfile(
          campaign: campaign,
          actionArea: _composeActionArea(context),
        ),
      ),
    );
  }

  Widget _composeActionArea(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 140,
          child: PrimaryButtonIcon(
            text: "Aprovar",
            icon: Icon(CupertinoIcons.checkmark_alt_circle),
            onPressed: () => _approve(context),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        SizedBox(
          width: 140,
          child: PrimaryButtonIcon(
            text: "Rejeitar",
            icon: Icon(CupertinoIcons.trash_circle),
            backgroundColor: Constants.secondaryColor3,
            textColor: Colors.redAccent,
            onPressed: () => _reject(context),
          ),
        )
      ],
    );
  }

  void _approve(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Container(
            height: 390,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  child: Image.asset("assets/images/approved.png"),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        "Campanha aprovada com sucesso",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Constants.primaryColor),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      PrimaryOutlineButton(
                        text: "Fechar e continuar",
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _reject(BuildContext context) {}
}
