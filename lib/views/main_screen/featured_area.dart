import 'package:flutter/material.dart';
import 'package:midowe_app/utils/constants.dart';
import 'package:midowe_app/views/campaign_profile/campaign_profile_view.dart';
import 'package:midowe_app/widgets/title_subtitle_heading.dart';
import 'package:page_transition/page_transition.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../models/CampaignData.dart' hide Element;

class FeaturedArea extends StatelessWidget {
  final Future<List<CampaignData>> campaigns;

  const FeaturedArea({Key? key, required this.campaigns}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<List<CampaignData>>(
      future: campaigns,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, top: 20.0, right: 20.0, bottom: 20.0),
                  child: TitleSubtitleHeading(
                    "Destaque",
                    "As pessoas estão apoiando estas campanhas",
                  ),
                ),
                SizedBox(
                  height: 190.0,
                  child: ListView(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(width: 15),
                      for (var campaign in snapshot.data!)
                        FeaturedItem(campaign: campaign),
                      SizedBox(width: 15),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Container(
              width: 0,
              height: 0,
            );
          }
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return Container(
          height: 100,
        );
      },
    ));
  }
}

class FeaturedItem extends StatelessWidget {
  final CampaignData campaign;

  const FeaturedItem({Key? key, required this.campaign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.leftToRight,
            child: CampaignProfileView(campaign: campaign),
          ),
        );

        // Helper.nextPage(context, );
      },
      child: Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        width: 160,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 140,
                  height: 140,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(1)),
                    child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: campaign.images![0].url,
                        width: double.infinity,
                        fit: BoxFit.fitHeight),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                campaign.title,
                style: TextStyle(
                  color: Constants.secondaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
