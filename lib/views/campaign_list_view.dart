import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:midowe_app/utils/colors.dart';
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
    ));
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
            height: 40,
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
                      Icons.settings_outlined,
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
            height: 73,
          ),
          SizedBox(
            width: 220,
            child: PrimaryButtonIcon(
                text: "Criar campanha",
                icon: Icon(
                  CupertinoIcons.plus,
                ),
                onPressed: () {
                  // todo
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
                  _composeItem("Abertura de furo de agua",
                      "https://picsum.photos/300/250"),
                  _composeItem("Construção de uma escola na zona",
                      "https://picsum.photos/300/201"),
                  _composeItem("Apoiar a reabilitação da estrada",
                      "https://picsum.photos/300/202"),
                  _composeItem("Produção do meu último album",
                      "https://picsum.photos/200/210"),
                  SizedBox(width: 15),
                ],
              )),
        ],
      ),
    );
  }

  Widget _composeItem(String title, String imageUrl) {
    return InkWell(
      onTap: () {},
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
        _composeCategory(
            "Solidariedade", "Campanhas sobre saúde, doenças e caridade"),
        _composeCategory("Educação", "Construção de escolas"),
        _composeCategory("Saúde", "Despesas médicas"),
      ]),
    );
  }

  Widget _composeCategory(String title, String description) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TitleSubtitleHeading(
          title,
          description,
        ),
        SizedBox(height: 10),
        _composeTopList(),
      ]),
    );
  }

  Widget _composeTopList() {
    return Column(
      children: [_composeTopListItem(), _composeTopListItem()],
    );
  }

  Widget _composeTopListItem() {
    return InkWell(
      onTap: () {},
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
                        image: "https://picsum.photos/300/280",
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
                  "Vamos dar as crianças do Centro Kurandzana um lar",
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
                  "29% - Meta: 68.000,00",
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
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              decoration: BoxDecoration(
                  color: Constants.secondaryColor3,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Text(
                "Doar",
                style: TextStyle(color: Constants.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
