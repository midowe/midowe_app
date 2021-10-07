import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:midowe_app/models/category_model.dart';
import 'package:midowe_app/utils/helper.dart';
import 'package:midowe_app/views/campaign_profile_view.dart';
import 'package:midowe_app/widgets/campaign_list_item.dart';
import 'package:midowe_app/widgets/title_subtitle_heading.dart';

import 'approval_profile_view.dart';

class CategoryCampaignView extends StatelessWidget {
  final Category category;

  CategoryCampaignView({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.arrowLeft,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleSubtitleHeading(
                          category.name,
                          category.description,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        _composeBody(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _composeBody(BuildContext context) {
    return Column(
      children: [
        /*CampaignListItem(
          title: "Vamos dar as crianças do Centro Kurandzana um lar",
          imageUrl: "https://picsum.photos/300/281",
          donatedAmount: 6000,
          targetAmount: 8000,
          onPressed: () {
            Helper.nextPage(context, CampaignProfileView());
          },
        ),
        CampaignListItem(
          title: "Abrigo para moradores de rua ba baixa da Cidade",
          imageUrl: "https://picsum.photos/300/282",
          donatedAmount: 6000,
          targetAmount: 8000,
          onPressed: () {
            Helper.nextPage(context, ApprovalProfileView());
          },
        ),
        CampaignListItem(
          title: "Vamos dar as crianças do Centro Kurandzana um lar",
          imageUrl: "https://picsum.photos/300/283",
          donatedAmount: 6000,
          targetAmount: 8000,
          onPressed: () {
            Helper.nextPage(context, ApprovalProfileView());
          },
        ),
        CampaignListItem(
          title: "Abrigo para moradores de rua ba baixa da Cidade",
          imageUrl: "https://picsum.photos/300/284",
          donatedAmount: 6000,
          targetAmount: 8000,
          onPressed: () {
            Helper.nextPage(context, ApprovalProfileView());
          },
        ),*/
      ],
    );
  }
}
