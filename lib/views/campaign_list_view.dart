import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:midowe_app/utils/colors.dart';
import 'package:midowe_app/widgets/primary_button_icon.dart';

class CampaignList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [HeaderArea(), featuredArea(), topByCategoryArea()],
      ),
    );
  }

  Container featuredArea() {
    return Container();
  }

  Container topByCategoryArea() {
    return Container();
  }
}

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
            height: 40,
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
                    onPressed: () {},
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
                    onPressed: () {},
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
                      Icons.settings_outlined,
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
            height: 73,
          ),
          SizedBox(
            width: 220,
            child: PrimaryButtonIcon(
                text: "Criar campanha",
                icon: Icon(
                  CupertinoIcons.plus,
                ),
                onPressed: () {
                  // todo
                }),
          ),
        ],
      ),
    );
  }
}
