import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:midowe_app/utils/colors.dart';
import 'package:midowe_app/utils/helper.dart';
import 'package:midowe_app/views/approval_list_view.dart';
import 'package:midowe_app/views/campaign_profile_view.dart';
import 'package:midowe_app/views/campaign_register_view.dart';
import 'package:midowe_app/views/category_campaign_view.dart';
import 'package:midowe_app/views/user_register_view.dart';
import 'package:midowe_app/widgets/campaign_list_item.dart';
import 'package:midowe_app/widgets/primary_button_icon.dart';
import 'package:midowe_app/widgets/title_subtitle_heading.dart';
import 'package:transparent_image/transparent_image.dart';

class CampaignList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HeaderArea(),
            FeaturedArea(),
            CategoriesArea(),
          ],
        ),
      ),
    );
  }
}

class HeaderArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: AssetImage("assets/images/hero-image-wide.png"),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 45,
          ),
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              Image(
                image: AssetImage("assets/images/logo-white.png"),
                height: 35,
              ),
              Expanded(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(41, 40),
                      alignment: Alignment.center,
                      backgroundColor: Colors.white,
                      primary: Constants.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    child: Icon(
                      CupertinoIcons.search,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      Helper.nextPage(context, ApprovalListView());
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(41, 40),
                      alignment: Alignment.center,
                      backgroundColor: Colors.white,
                      primary: Constants.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    child: Icon(
                      Icons.checklist,
                      color: Colors.black87,
                    ),
                  )
                ],
              )),
              SizedBox(
                width: 15,
              ),
            ],
          ),
          SizedBox(
            height: 53,
          ),
          SizedBox(
            width: 220,
            child: PrimaryButtonIcon(
                text: "Criar campanha",
                icon: Icon(
                  CupertinoIcons.plus,
                ),
                onPressed: () {
                  Helper.nextPage(context, UserRegisterView());
                }),
          ),
        ],
      ),
    );
  }
}

class FeaturedArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: 20.0, top: 30.0, right: 20.0, bottom: 20.0),
            child: TitleSubtitleHeading(
              "Destaque",
              "Campanhas de doação criadas recentimente",
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
                  _composeItem(
                    "Abertura de furo de agua",
                    "https://picsum.photos/300/250",
                    context,
                  ),
                  _composeItem(
                    "Construção de uma escola na zona",
                    "https://picsum.photos/300/201",
                    context,
                  ),
                  _composeItem(
                    "Apoiar a reabilitação da estrada",
                    "https://picsum.photos/300/202",
                    context,
                  ),
                  _composeItem(
                    "Produção do meu último album",
                    "https://picsum.photos/200/210",
                    context,
                  ),
                  SizedBox(width: 15),
                ],
              )),
        ],
      ),
    );
  }

  Widget _composeItem(String title, String imageUrl, BuildContext context) {
    return InkWell(
      onTap: () {
        Helper.nextPage(context, CampaignProfileView());
      },
      customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        width: 160,
        child: Column(
          children: [
            Container(
              width: 150,
              height: 140,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: imageUrl,
                      ).image),
                  borderRadius: BorderRadius.all(Radius.circular(25))),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(
                color: Constants.secondaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class CategoriesArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _composeCategory("Solidariedade",
            "Campanhas sobre saúde, doenças e caridade", context),
        _composeCategory("Educação", "Construção de escolas", context),
        _composeCategory("Saúde", "Despesas médicas", context),
      ]),
    );
  }

  Widget _composeCategory(
      String title, String description, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TitleSubtitleHeading(
          title,
          description,
        ),
        SizedBox(height: 10),
        _composeTopList(context),
        Center(
          child: IconButton(
            icon: Icon(
              CupertinoIcons.chevron_compact_down,
            ),
            onPressed: () {
              Helper.nextPage(context,
                  CategoryCampaignView(title: title, description: description));
            },
          ),
        )
      ]),
    );
  }

  Widget _composeTopList(BuildContext context) {
    return Column(
      children: [
        CampaignListItem(
          title: "Vamos dar as crianças do Centro Kurandzana um lar",
          imageUrl: "https://picsum.photos/300/280",
          donatedAmount: 6000,
          targetAmount: 8000,
          onPressed: () {
            Helper.nextPage(context, CampaignProfileView());
          },
        ),
        CampaignListItem(
          title: "Vamos dar as crianças do Centro Kurandzana um lar",
          imageUrl: "https://picsum.photos/300/280",
          donatedAmount: 6000,
          targetAmount: 8000,
          onPressed: () {
            Helper.nextPage(context, CampaignProfileView());
          },
        ),
      ],
    );
  }
}
