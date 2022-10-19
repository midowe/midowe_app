import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:midowe_app/components/social_icon_button.dart';
import 'package:midowe_app/helpers/constants.dart';
import 'package:midowe_app/helpers/formatter.dart';
import 'package:midowe_app/helpers/router_helper.dart';
import 'package:midowe_app/models/category_model.dart';
import 'package:midowe_app/models/donation_model.dart';
import 'package:midowe_app/models/fundraiser.dart';
import 'package:midowe_app/providers/campaign_provider.dart';
import 'package:midowe_app/providers/category_provider.dart';
import 'package:midowe_app/providers/fundraiser_provider.dart';
import 'package:midowe_app/screens/image_prevew_screen.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/campaign_data.dart';

class CampaignProfile extends StatelessWidget {
  final CampaignData campaign;
  final Widget actionArea;
  final Category? category;

  const CampaignProfile(
      {required this.campaign, required this.actionArea, this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CampaignHeader(
          campaign: this.campaign,
          category: this.category,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: actionArea,
        ),
        CampaignStats(
          campaign: campaign,
        ),
        CampaignContent(
          campaign: this.campaign,
        ),
        if (category != null) CampaignCategoryDetail(category: this.category),
        CampaignDonations(
          campaign: campaign,
        ),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }
}

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
                        "Verificado",
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
              image: campaign.images![0].url,
            )),
      ],
    );
  }
}

class CampaignStats extends StatelessWidget {
  final CampaignData campaign;

  const CampaignStats({Key? key, required this.campaign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: [
          Container(
              child: Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: [
              Text(
                "${campaign.total_donations} apoiantes (${Formatter.currencyDouble((campaign.current_balance.toDouble() * 100) / campaign.target_amount.toDouble())}%) - Meta ${Formatter.currencyDouble(campaign.target_amount.toDouble())}  termina ${campaign.target_date}.",
                style: TextStyle(color: Constants.secondaryColor2),
              ),
            ],
          )),
          /* if (campaign.target_date != '')
            Icon(
              FontAwesomeIcons.calendarAlt,
              size: 18,
            ),
          if (campaign.target_date != '')
            Text(
              "${Formatter.dayMonth(campaign.target_date)}",
              style: TextStyle(color: Constants.primaryColor),
            ),
           */
        ],
      ),
    );
  }
}

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
        //  composeShareArea()
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
                        RouterHelper.nextPage(
                            context, new ImagePreviewScreen(imageUrl: image))
                      },
                      child: Container(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
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

class CampaignDonations extends StatelessWidget {
  final CampaignData campaign;

  const CampaignDonations({required this.campaign});

  @override
  Widget build(BuildContext context) {
    final campaignProvider = GetIt.I.get<CampaignProvider>();
    Future<List<Donation>> donations =
        campaignProvider.listDonationsOfCampaign(campaign.id);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 35,
          ),
          Text(
            "Doações recebidas",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
          SizedBox(
            height: 5,
          ),
          FutureBuilder<List<Donation>>(
              future: donations,
              builder: (context, snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  children = <Widget>[
                    SizedBox(width: 15),
                    for (var donation in snapshot.data!)
                      ListTile(
                        title: Text(donation.donor_name),
                        subtitle: Text(donation.amount.toString() +
                            " MT - " +
                            donation.createdAt),
                      ),
                  ];
                } else if (snapshot.hasError) {
                  children = <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    )
                  ];
                } else {
                  children = const <Widget>[
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text(
                          "Nenhuma doação recebida até agora",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ))
                  ];
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: children,
                  ),
                );
              }),
        ],
      ),
    );
  }
}

class CampaignCategoryDetail extends StatelessWidget {
  final Category? category;

  const CampaignCategoryDetail({Key? key, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 35,
          ),
          Text(
            "Categoria",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            category!.name,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
          ),
          Text(
            category!.description,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}

class CampaignAuthor extends StatefulWidget {
  final int campaignId;

  const CampaignAuthor({Key? key, required this.campaignId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CampaignAuthorState();
  }
}

class _CampaignAuthorState extends State<CampaignAuthor> {
  final fundraiserProvider = GetIt.I.get<FundraiserProvider>();
  late Future<Fundraiser>? fundraiser;

  @override
  void initState() {
    super.initState();
    this.fundraiser =
        fundraiserProvider.fetchFundraiserByCampaignId(widget.campaignId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Fundraiser>(
      future: fundraiser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: Row(
              children: [
                CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(snapshot.data!.picture)),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.data!.full_name,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(snapshot.data!.headline),
                  ],
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return CircularProgressIndicator();
      },
    );
  }
}
