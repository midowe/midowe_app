import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:midowe_app/models/campaign_pending_model.dart';
import 'package:midowe_app/providers/campaign_provider.dart';
import 'package:midowe_app/utils/constants.dart';
import 'package:midowe_app/utils/helper.dart';
import 'package:midowe_app/views/approval/approval_list_view.dart';
import 'package:midowe_app/views/campaign_register_view.dart';
import 'package:midowe_app/views/main_screen/main_screen_view.dart';
import 'package:midowe_app/views/user_auth/user_login_view.dart';
import 'package:midowe_app/views/user_profile/user_profile_view.dart';
import 'package:midowe_app/widgets/primary_button_icon.dart';

class HeaderArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: AssetImage("assets/images/hero-image-wide.png"),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 45,
          ),
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              Image(
                image: AssetImage("assets/images/logo-white.png"),
                height: 35,
              ),
              Expanded(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PendingApprovalButton(),
                  SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: () async {
                      try {
                        await Amplify.Auth.getCurrentUser();
                        Helper.nextPage(context, UserProfileView());
                      } on AuthException catch (_) {
                        Helper.nextPage(
                          context,
                          UserLoginView(
                            successWidget: MainScreenView(),
                          ),
                        );
                      }
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(41, 40),
                      alignment: Alignment.center,
                      backgroundColor: Colors.white,
                      primary: Constants.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    child: Icon(
                      Icons.person,
                      color: Colors.black87,
                    ),
                  )
                ],
              )),
              SizedBox(
                width: 15,
              ),
            ],
          ),
          SizedBox(
            height: 53,
          ),
          SizedBox(
            width: 220,
            child: PrimaryButtonIcon(
                text: "Criar campanha",
                icon: Icon(
                  CupertinoIcons.plus,
                ),
                onPressed: () async {
                  try {
                    await Amplify.Auth.getCurrentUser();
                    Helper.nextPage(context, CampaignRegisterView());
                  } on AuthException catch (_) {
                    Helper.nextPage(
                      context,
                      UserLoginView(
                        successWidget: CampaignRegisterView(),
                      ),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}

class PendingApprovalButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PendingApprovalButtonState();
  }
}

class _PendingApprovalButtonState extends State<PendingApprovalButton> {
  final campaignProvider = GetIt.I.get<CampaignProvider>();
  late Future<CampaignPending> campaignPending;

  @override
  void initState() {
    super.initState();
    this.campaignPending = campaignProvider.fetchPendingApproval('', '');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CampaignPending>(
      future: campaignPending,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return TextButton(
            onPressed: () {
              Helper.nextPage(
                context,
                ApprovalListView(
                  campaignPending: snapshot.data!,
                ),
              );
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(41, 40),
              alignment: Alignment.center,
              backgroundColor: Colors.white,
              primary: Constants.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.verified_outlined,
                  color: Colors.black87,
                ),
                Container(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                      color: Constants.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "${snapshot.data!.count}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 5,
                )
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return TextButton(
          onPressed: () {
            Helper.nextPage(
              context,
              ApprovalListView(
                campaignPending: CampaignPending(0, List.empty()),
              ),
            );
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(41, 40),
            alignment: Alignment.center,
            backgroundColor: Colors.white,
            primary: Constants.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          child: Icon(
            Icons.verified_outlined,
            color: Colors.black87,
          ),
        );
      },
    );
  }
}
