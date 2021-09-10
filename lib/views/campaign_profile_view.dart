import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:midowe_app/utils/colors.dart';
import 'package:midowe_app/utils/helper.dart';
import 'package:midowe_app/views/campaign_donate_view.dart';
import 'package:midowe_app/widgets/primary_button_icon.dart';
import 'package:midowe_app/widgets/social_share_button.dart';
import 'package:midowe_app/widgets/thank_you_dialog.dart';
import 'package:transparent_image/transparent_image.dart';

class CampaignProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Future.delayed(Duration.zero, () => _showSuccessDialog(context));

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CampaignProfileHeader(),
              CampaignProfileBody(),
            ]),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Container(
            height: 430,
            child: ThankYouDialogBox(
                amount: "100MT",
                paymentMethod: "M-Pesa",
                userPhone: "842058817",
                userName: "Américo Chaquisse"),
          ),
        );
      },
    );
  }
}

class CampaignProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: "https://picsum.photos/600/400",
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Text(
            "Vamos dar as crianças do Centro Lirandzu um lar",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}

class CampaignProfileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _composeContentArea(context),
          _composeOtherPicturesArea(),
          _composeShareArea(),
          _composeDonationsArea(),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  Widget _composeContentArea(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: PrimaryButtonIcon(
              text: "Fazer doação",
              icon: Icon(CupertinoIcons.heart),
              onPressed: () {
                Helper.nextPage(context, CampaignDonateView());
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: [
              Text(
                "12 doações (1.800,00 MT)",
                style: TextStyle(
                  color: Constants.primaryColor,
                ),
              ),
              Text(
                "Meta: 120.000,00 MT",
                style: TextStyle(color: Constants.primaryColor),
              ),
              Text(
                "Deadline: 20.Dez.2021",
                style: TextStyle(color: Constants.primaryColor),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "A educação é um direito de todos: clichê frase que caracteriza todo o objetivo por trás do centro Kurandzana, criado em 2010 como braço pedagógico da educação nas zonas rurais.\n\n Em março de 2018, devido ao ciclone registado na zona centro do país, a escola foi destruída. Em uma nova tentativa de reerguê-la, fomos novamente surpreendidos por um outro ciclone. situação de vulnerabilidade social!",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _composeOtherPicturesArea() {
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

  Widget _composeShareArea() {
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
                SocialShareButton(
                  icon: Icon(FontAwesomeIcons.facebook),
                  onPressed: () {},
                ),
                SocialShareButton(
                  icon: Icon(FontAwesomeIcons.whatsapp),
                  onPressed: () {},
                ),
                SocialShareButton(
                  icon: Icon(FontAwesomeIcons.twitter),
                  onPressed: () {},
                ),
                SocialShareButton(
                  icon: Icon(FontAwesomeIcons.linkedin),
                  onPressed: () {},
                )
              ],
            )
          ],
        ));
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
