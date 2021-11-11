import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:midowe_app/utils/constants.dart';
import 'package:midowe_app/utils/helper.dart';
import 'package:midowe_app/views/approval/approval_list_view.dart';
import 'package:midowe_app/views/campaign_register_view.dart';
import 'package:midowe_app/views/campaign_search_view.dart';
import 'package:midowe_app/views/user_auth/user_login_view.dart';
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
                  TextButton(
                    onPressed: () {
                      Helper.nextPage(context, CampaignSearchView());
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
                      CupertinoIcons.search,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      Helper.nextPage(context, ApprovalListView());
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
                      Icons.checklist,
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
