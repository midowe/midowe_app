import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:midowe_app/models/category_campaigns.dart';
import 'package:midowe_app/providers/campaign_provider.dart';
import 'package:midowe_app/utils/helper.dart';
import 'package:midowe_app/views/campaign_profile/campaign_profile_view.dart';
import 'package:midowe_app/views/category_campaign/category_campaign_view.dart';
import 'package:midowe_app/widgets/campaign_list_item.dart';
import 'package:midowe_app/widgets/title_subtitle_heading.dart';

class CategoriesArea extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CategoriesAreaState();
  }
}

class _CategoriesAreaState extends State<CategoriesArea> {
  final campaignProvider = GetIt.I.get<CampaignProvider>();
  late Future<List<CategoryCampaigns>> categoryCampaigns;

  @override
  void initState() {
    super.initState();
    this.categoryCampaigns = campaignProvider.fetchTopByCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(20.0),
      child: FutureBuilder<List<CategoryCampaigns>>(
        future: categoryCampaigns,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var item in snapshot.data!)
                    CategoryItemArea(categoryCampaignItem: item),
                  SizedBox(
                    height: 30,
                  )
                ]);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class CategoryItemArea extends StatelessWidget {
  final CategoryCampaigns categoryCampaignItem;

  const CategoryItemArea({Key? key, required this.categoryCampaignItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 0.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TitleSubtitleHeading(
          categoryCampaignItem.category.name,
          categoryCampaignItem.category.description,
        ),
        SizedBox(height: 10),
        Column(
          children: [
            for (var campaign in categoryCampaignItem.campaigns)
              CampaignListItem(
                campaign: campaign,
                onPressed: () {
                  Helper.nextPage(
                      context,
                      CampaignProfileView(
                        campaign: campaign,
                      ));
                },
              ),
          ],
        ),
        if (categoryCampaignItem.campaigns.length > 1)
          Center(
            child: IconButton(
              icon: Icon(
                CupertinoIcons.chevron_compact_down,
              ),
              onPressed: () {
                Helper.nextPage(
                    context,
                    CategoryCampaignView(
                        category: categoryCampaignItem.category));
              },
            ),
          )
      ]),
    );
  }
}
