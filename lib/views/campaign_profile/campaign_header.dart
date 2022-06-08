import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../models/CampaignData.dart';

class CampaignHeader extends StatelessWidget {
  final CampaignData campaign;

  const CampaignHeader({Key? key, required this.campaign}) : super(key: key);

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
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          width: double.infinity,
          fit: BoxFit.fitWidth,
          image: campaign.url,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Wrap(
            children: [
              Text(
                campaign.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              if (campaign.verified)
                SizedBox(
                  width: 5,
                ),
              if (campaign.verified)
                Image(
                  image: AssetImage("assets/images/verified.png"),
                  height: 20,
                  width: 20,
                ),
            ],
          ),
        )
      ],
    );
  }
}
