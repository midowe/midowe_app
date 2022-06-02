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
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                width: double.infinity,
                fit: BoxFit.fitWidth,
                image: campaign.url,
              ),
            ),
            Positioned(
              top: 45,
              left: 15,
              child: IconButton(
                icon: Icon(
                  FontAwesomeIcons.arrowLeft,
                ),
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Wrap(
            children: [
              if (campaign.verified)
                Image(
                  image: AssetImage("assets/images/verified.png"),
                  height: 24,
                  width: 24,
                ),
              SizedBox(
                height: 5,
              ),
              Text(
                campaign.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        )
      ],
    );
  }
}
