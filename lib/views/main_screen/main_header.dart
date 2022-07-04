import 'package:flutter/material.dart';
import 'package:midowe_app/utils/constants.dart';
import 'package:page_transition/page_transition.dart';

import 'campaigns_page.dart';

class MainHeader extends StatelessWidget {
  TextEditingController seachController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 155.0,
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
              top: 100.0,
              left: 20.0,
              right: 20.0,
              child: AppBar(
                backgroundColor: Colors.white,
                primary: false,
                flexibleSpace: Container(
                    decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [
                        Colors.blueGrey,
                        Constants.primaryBackGround,
                      ]),
                )),
                leading: Icon(Icons.search, color: Colors.grey),
                title: TextField(
                  controller: seachController,
                  decoration: InputDecoration(
                      hintText: "Pesquisar",
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey)),
                  onSubmitted: (value) {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.leftToRightWithFade,
                        child: CampaignsPage(
                          query: value,
                        ),
                      ),
                    );
                  },
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.blueGrey),
                    onPressed: () {
                      seachController.clear();
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
