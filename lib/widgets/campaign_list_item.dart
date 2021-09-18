import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:midowe_app/utils/constants.dart';
import 'package:midowe_app/utils/helper.dart';
import 'package:midowe_app/views/campaign_profile_view.dart';
import 'package:transparent_image/transparent_image.dart';

class CampaignListItem extends StatelessWidget {
  final String title, imageUrl;
  final double donatedAmount, targetAmount;
  final VoidCallback onPressed;

  CampaignListItem(
      {required this.title,
      required this.imageUrl,
      required this.donatedAmount,
      required this.targetAmount,
      required this.onPressed});

  String _getPercent() {
    double percent = 100 * donatedAmount / targetAmount;
    return percent.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: this.imageUrl,
                      ).image),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  this.title,
                  style: TextStyle(
                    color: Constants.secondaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "${_getPercent()}% - Meta: $targetAmount",
                  style: TextStyle(
                    color: Constants.secondaryColor2,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            )),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                  color: Constants.secondaryColor3,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Icon(
                CupertinoIcons.chevron_right,
                size: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
