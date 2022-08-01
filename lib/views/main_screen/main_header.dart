import 'package:flutter/material.dart';
import 'package:midowe_app/utils/constants.dart';
import 'package:page_transition/page_transition.dart';

import 'campaigns_page.dart';

class MainHeader extends StatelessWidget {
  TextEditingController seachController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 170.0,
        child: Stack(
          children: <Widget>[
            Container(
              // Background
              child: Center(
                child: Image(
                  image: AssetImage("assets/images/logo-white.png"),
                  width: 100,
                  color: Colors.white,
                ),
              ),
              color: Constants.secondaryColor2,
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width,
            ),

            Container(), // Required some widget in between to float AppBar

            Positioned(
              // To take AppBar Size only
              top: 120.0,
              left: 40.0,
              right: 40.0,
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.leftToRightWithFade,
                        child: CampaignsPage(
                          query: "",
                        ),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Constants.secondaryColor2,
                    primary: Constants.secondaryColor2,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    side: BorderSide(
                        color: Constants.primaryBackGround,
                        width: 2.0,
                        style: BorderStyle.solid),
                  ),
                  child: Text("EXPLORAR",
                      style: TextStyle(color: Constants.primaryBackGround))),
            )
          ],
        ));
  }
}
