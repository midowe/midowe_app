import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:midowe_app/utils/constants.dart';
import 'package:photo_view/photo_view.dart';

class CampaignImageView extends StatelessWidget {
  final String imageUrl;

  const CampaignImageView({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PhotoView(
            imageProvider: NetworkImage(imageUrl),
          ),
          Positioned(
            top: 45,
            left: 15,
            child: IconButton(
              icon: Icon(
                FontAwesomeIcons.arrowLeft,
              ),
              color: Constants.primaryColor,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }
}
