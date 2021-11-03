import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:midowe_app/models/campaign_model.dart';
import 'package:midowe_app/models/statistics_model.dart';
import 'package:midowe_app/providers/accounting_provider.dart';
import 'package:midowe_app/utils/constants.dart';
import 'package:midowe_app/utils/formatter.dart';
import 'package:midowe_app/widgets/social_icon_button.dart';
import 'package:transparent_image/transparent_image.dart';

class CampaignProfile extends StatelessWidget {
  final Campaign campaign;
  final Widget actionArea;

  const CampaignProfile({
    required this.campaign,
    required this.actionArea,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CampaignHeader(
          campaign: this.campaign,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: actionArea,
        ),
        _CampaignStats(
          campaign: campaign,
        ),
        _CampaignContent(
          campaign: this.campaign,
        ),
        _composeDonationsArea(),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }

  Widget _composeDonationsArea() {
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
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Nenhuma doação recebida até agora",
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

class _CampaignHeader extends StatelessWidget {
  final Campaign campaign;

  const _CampaignHeader({Key? key, required this.campaign}) : super(key: key);

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
                image: campaign.profileImage,
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
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                campaign.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 5,
              ),
              Wrap(
                runSpacing: 8.0,
                spacing: 10.0,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Constants.secondaryColor3),
                      child: IntrinsicWidth(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Categoria:",
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            //todo: Text(campaign.category.name),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      )),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Constants.secondaryColor3),
                      child: IntrinsicWidth(
                        child: Row(
                          children: [
                            /*todo CircleAvatar(
                                radius: 10,
                                backgroundImage:
                                    NetworkImage(campaign.user.picture)),*/
                            SizedBox(
                              width: 10,
                            ),
                            //todo Text(campaign.user.fullName),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ))
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

class _CampaignStats extends StatefulWidget {
  final Campaign campaign;

  const _CampaignStats({Key? key, required this.campaign}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CampaignStatsState();
}

class _CampaignStatsState extends State<_CampaignStats> {
  final accountingProvider = GetIt.I.get<AccountingProvider>();
  late Future<Statistics> statistics;

  @override
  void initState() {
    super.initState();
    this.statistics =
        accountingProvider.getStatistics(widget.campaign.campaignId);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: [
          Icon(
            FontAwesomeIcons.heart,
            size: 20,
          ),
          Container(
            child: FutureBuilder<Statistics>(
              future: statistics,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    "${snapshot.data!.totalAmount} MT (${snapshot.data!.totalDonations})",
                    style: TextStyle(
                      color: Constants.primaryColor,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return Container(
                  width: 0,
                  height: 0,
                );
              },
            ),
          ),
          if (widget.campaign.targetAmount != null)
            Icon(
              FontAwesomeIcons.searchDollar,
              size: 20,
            ),
          if (widget.campaign.targetAmount != null)
            Text(
              "${Formatter.currency(widget.campaign.targetAmount)} MT",
              style: TextStyle(color: Constants.primaryColor),
            ),
          if (widget.campaign.targetDate != null)
            Icon(
              FontAwesomeIcons.calendarAlt,
              size: 18,
            ),
          if (widget.campaign.targetDate != null)
            Text(
              "${Formatter.dayMonth(widget.campaign.targetDate)}",
              style: TextStyle(color: Constants.primaryColor),
            )
        ],
      ),
    );
  }
}

class _CampaignContent extends StatelessWidget {
  final Campaign campaign;

  const _CampaignContent({Key? key, required this.campaign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: MarkdownBody(
            data: campaign.content,
            styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                .copyWith(textScaleFactor: 1.1),
          ),
        ),
        composeOtherPicturesArea(),
        composeShareArea()
      ],
    );
  }

  Widget composeOtherPicturesArea() {
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
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
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
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: "https://picsum.photos/300/250",
                          ).image),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                SizedBox(width: 15),
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: "https://picsum.photos/300/251",
                          ).image),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                SizedBox(width: 15),
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: "https://picsum.photos/300/252",
                          ).image),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                SizedBox(width: 15),
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: "https://picsum.photos/300/253",
                          ).image),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                SizedBox(width: 20),
              ],
            )),
      ],
    );
  }

  Widget composeShareArea() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 35,
            ),
            Text(
              "Partilhar nas redes sociais",
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
                  onPressed: () {},
                ),
                SocialIconButton(
                  icon: Icon(FontAwesomeIcons.whatsapp),
                  onPressed: () {},
                ),
                SocialIconButton(
                  icon: Icon(FontAwesomeIcons.twitter),
                  onPressed: () {},
                ),
                SocialIconButton(
                  icon: Icon(FontAwesomeIcons.linkedin),
                  onPressed: () {},
                )
              ],
            )
          ],
        ));
  }
}
