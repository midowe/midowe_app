import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:midowe_app/models/category_model.dart';
import 'package:midowe_app/widgets/title_subtitle_heading.dart';

import 'category_campaign_list.dart';

class CategoryCampaignView extends StatelessWidget {
  final Category category;

  CategoryCampaignView({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: CategoryCampaignList(
                    category: category,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
