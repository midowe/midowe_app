import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:midowe_app/models/campaign_model.dart';
import 'package:midowe_app/utils/helper.dart';
import 'package:midowe_app/views/campaign_profile/campaign_author.dart';
import 'package:midowe_app/views/campaign_profile/campaign_image_view.dart';
import 'package:midowe_app/widgets/social_icon_button.dart';

import '../../models/CampaignData.dart';
//import 'package:flutter_share_me/flutter_share_me.dart';

class CampaignContent extends StatelessWidget {
  final CampaignData campaign;

  const CampaignContent({Key? key, required this.campaign}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: MarkdownBody(
            data: campaign.description,
            styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                .copyWith(textScaleFactor: 1.1),
          ),
        ),
        composeAuthorArea(),
        composeOtherPicturesArea(context),
        if (campaign.approved) composeShareArea()
      ],
    );
  }

  Widget composeAuthorArea() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: 35,
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Text(
          "Beneficiario",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: CampaignAuthor(campaignId: campaign.id),
      )
    ]);
  }

  Widget composeOtherPicturesArea(BuildContext context) {


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 35,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: Text(
            "Outras imagens",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
            height: 140.0,
            child: ListView(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(width: 20),
                for (var image in campaign.images!)
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: InkWell(
                      onTap: () => {
                        Helper.nextPage(
                            context, new CampaignImageView(imageUrl: image))
                      },
                      child: Container(
                        width: 140,
                        height: 140,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: FadeInImage.assetNetwork(
                              placeholder: circularProgressIndicatorSmall,
                              image: image.url,
                              width: double.infinity,
                              fit: BoxFit.fitWidth),
                        ),
                      ),
                    ),
                  ),
                SizedBox(width: 5),
              ],
            )),
      ],
    );
  }

  Widget composeShareArea() {
    //final FlutterShareMe flutterShareMe = FlutterShareMe();

    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 35,
          ),
          Text(
            "Contribua partilhando nas redes sociais",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          SizedBox(
            height: 15,
          ),
          Wrap(
            spacing: 15.0,
            children: [
              SocialIconButton(
                icon: Icon(FontAwesomeIcons.facebook),
                onPressed: () {
                 /* flutterShareMe.shareToFacebook(
                      url:
                          "https://midowe.co.mz/d/${campaign.categoryId}/${campaign.campaignId}",
                      msg:
                          "${campaign.title}. Para doar: https://midowe.co.mz/d/${campaign.categoryId}/${campaign.campaignId}");*/
                },
              ),
              SocialIconButton(
                icon: Icon(FontAwesomeIcons.whatsapp),
                onPressed: () {
                 /* flutterShareMe.shareToWhatsApp(
                      msg:
                          "${campaign.title}. Para doar: https://midowe.co.mz/d/${campaign.categoryId}/${campaign.campaignId}");*/
                },
              ),
              SocialIconButton(
                icon: Icon(FontAwesomeIcons.twitter),
                onPressed: () {
             /*     flutterShareMe.shareToTwitter(
                      url:
                          "https://midowe.co.mz/d/${campaign.categoryId}/${campaign.campaignId}",
                      msg:
                          "${campaign.title}. Para doar: https://midowe.co.mz/d/${campaign.categoryId}/${campaign.campaignId}");*/
                },
              ),
              SocialIconButton(
                icon: Icon(FontAwesomeIcons.shareAlt),
                onPressed: () {
                /*  flutterShareMe.shareToSystem(
                      msg:
                          "${campaign.title}. Para doar: https://midowe.co.mz/d/${campaign.categoryId}/${campaign.campaignId}");*/
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
