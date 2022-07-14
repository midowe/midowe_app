import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:midowe_app/utils/constants.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:midowe_app/models/category_model.dart';

import '../../models/CampaignData.dart';

class CampaignHeader extends StatelessWidget {
  final CampaignData campaign;
  final Category? category;

  const CampaignHeader(
      {Key? key, required this.campaign, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
          child: IconButton(
            icon: Icon(
              FontAwesomeIcons.arrowLeft,
            ),
            color: Constants.primaryColor,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        if (category != null)
          Align(
              alignment: Alignment.center,
              child: Text(
                category!.name,
                style: TextStyle(fontSize: 12, color: Constants.primaryColor),
              )),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Wrap(
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    campaign.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ))
            ],
          ),
        ),
        if (campaign.verified)
          Align(
              alignment: Alignment.center,
              child: Container(
                width: 100,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    color: Constants.primaryBackGround,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage("assets/images/verified.png"),
                        height: 18,
                        width: 18,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "verificado",
                        style: TextStyle(
                            fontSize: 10, color: Constants.primaryColor),
                      ),
                    ],
                  ),
                ),
              )),
        SizedBox(
          height: 5,
        ),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              width: double.infinity,
              fit: BoxFit.fitWidth,
              image: campaign.url,
            )),
      ],
    );
  }
}
