import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:midowe_app/models/category_model.dart';
import 'package:midowe_app/utils/helper.dart';
import 'package:midowe_app/views/campaign_profile/campaign_profile_view.dart';
import 'package:midowe_app/views/category_campaign/category_campaign_view.dart';
import 'package:midowe_app/widgets/campaign_list_item.dart';
import 'package:midowe_app/widgets/title_subtitle_heading.dart';

import '../../providers/category_provider.dart';

class CategoriesArea extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CategoriesAreaState();
  }
}

class _CategoriesAreaState extends State<CategoriesArea> {
  final categoryProvider = GetIt.I.get<CategoryProvider>();
  late Future<List<Category>> categories;

  @override
  void initState() {
    super.initState();
    this.categories = categoryProvider.fetchAllCategories('1','10');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(20.0),
      child: FutureBuilder<List<Category>>(
        future: categories,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            for (var item in snapshot.data!){

              if(!item.campaigns.isEmpty)
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var item in snapshot.data!)
                        CategoryItemArea(categoryItem: item),
                      SizedBox(
                        height: 10,
                      )
                    ]);
            }
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
  final Category categoryItem;

  const CategoryItemArea({Key? key, required this.categoryItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    if(!categoryItem.campaigns.isEmpty)
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 0.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

        if(categoryItem.campaigns.length>0)
        TitleSubtitleHeading(
          categoryItem.name,
          categoryItem.description,

        ),
        if(categoryItem.campaigns.length>0)
        SizedBox(height: 10),
        if(categoryItem.campaigns.length>0)
        Column(
          children: [
            for (var campaign in categoryItem.campaigns)
              CampaignListItem(
                campaign: campaign,
                onPressed: () {
                  Helper.nextPage(
                      context,
                      CampaignProfileView(
                          campaign: campaign,
                          category: categoryItem));
                },
              ),
          ],
        ),
        if (categoryItem.campaigns.length > 2)
          Center(
            child: IconButton(
              icon: Icon(
                CupertinoIcons.chevron_compact_down,
              ),
              onPressed: () {
                Helper.nextPage(
                    context,
                    CategoryCampaignView(
                        category: categoryItem));
              },
            ),
          )
      ]),
    );

  else return Text("");
  }
}
