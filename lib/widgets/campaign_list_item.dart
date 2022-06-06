import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:midowe_app/models/CampaignData.dart';
import 'package:midowe_app/utils/constants.dart';
import 'package:midowe_app/utils/formatter.dart';

class CampaignListItem extends StatelessWidget {
  final CampaignData campaign;
  final VoidCallback onPressed;

  CampaignListItem({required this.campaign, required this.onPressed});

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
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: FadeInImage.assetNetwork(
                    placeholder: circularProgressIndicatorSmall,
                    image: campaign.url,
                    width: double.infinity,
                    fit: BoxFit.fitHeight),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  campaign.title,
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
                  "${Formatter.currencyDouble((campaign.current_balance.toDouble() * 100) / campaign.target_amount.toDouble())} % - Meta ${Formatter.currencyDouble(campaign.target_amount.toDouble())} MT",
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
