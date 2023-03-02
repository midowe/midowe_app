import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:midowe_app/components/campaign_list_item.dart';
import 'package:midowe_app/components/home_header.dart';
import 'package:midowe_app/components/title_subtitle_heading.dart';
import 'package:midowe_app/helpers/constants.dart';
import 'package:midowe_app/helpers/router_helper.dart';
import 'package:midowe_app/models/campaign_data.dart';
import 'package:midowe_app/models/category_model.dart';
import 'package:midowe_app/providers/campaign_provider.dart';
import 'package:midowe_app/providers/category_provider.dart';
import 'package:midowe_app/screens/campaign_profile_screen.dart';
import 'package:midowe_app/screens/campaign_search_screen.dart';
import 'package:midowe_app/screens/category_campaign_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePageExplore extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageCampaigns();
  }
}

class _HomePageCampaigns extends State<HomePageExplore> {
  final campaignProvider = GetIt.I.get<CampaignProvider>();
  late Future<List<CampaignData>> trendingCampaigns;

  @override
  void initState() {
    super.initState();
    this.trendingCampaigns = campaignProvider.getTrendingCampaigns();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          HomeHeader(
            actionButton: TextButton(
              onPressed: () {
                RouterHelper.nextPage(context, CampaignSearchScreen());
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(41, 40),
                alignment: Alignment.center,
                backgroundColor: Constants.secondaryColor4,
                foregroundColor: Constants.primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              child: Icon(
                Icons.search,
                color: Colors.black87,
              ),
            ),
          ),
          RefreshIndicator(
              backgroundColor: Colors.purple,
              color: Colors.white,
              child: Column(children: [
                FeaturedArea(campaigns: trendingCampaigns),
                CategoriesArea(),
              ]),
              onRefresh: _pullRefresh)
        ],
      ),
    );
  }

  Future<void> _pullRefresh() async {
    Future<List<CampaignData>> campas = campaignProvider.getTrendingCampaigns();
    setState(() {
      trendingCampaigns = campas;
    });
  }
}

class FeaturedArea extends StatelessWidget {
  final Future<List<CampaignData>> campaigns;

  const FeaturedArea({Key? key, required this.campaigns}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<List<CampaignData>>(
      future: campaigns,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, top: 20.0, right: 20.0, bottom: 20.0),
                  child: TitleSubtitleHeading(
                    "Destaque",
                    "As pessoas estão apoiando estas campanhas",
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
                      for (var campaign in snapshot.data!)
                        FeaturedItem(campaign: campaign),
                      SizedBox(width: 15),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Container(
              width: 0,
              height: 0,
            );
          }
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return Container(
          height: 100,
        );
      },
    ));
  }
}

class FeaturedItem extends StatelessWidget {
  final CampaignData campaign;

  const FeaturedItem({Key? key, required this.campaign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        RouterHelper.nextPage(
            context, CampaignProfileScreen(campaign: campaign));
      },
      child: Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        width: 160,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 140,
                  height: 140,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(1)),
                    child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: campaign.images![0].url,
                        width: double.infinity,
                        fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                campaign.title,
                style: TextStyle(
                  color: Constants.secondaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
    this.categories = categoryProvider.fetchAllCategories('1', '10');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(20.0),
        child: RefreshIndicator(
          onRefresh: _pullRefresh,
          color: Colors.white,
          backgroundColor: Colors.purple,
          strokeWidth: 5,
          child: FutureBuilder<List<Category>>(
            future: categories,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                for (var item in snapshot.data!) {
                  if (item.campaigns.isNotEmpty)
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var item in snapshot.data!)
                            if (item.campaigns.isNotEmpty)
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
        ));
  }

  Future<void> _pullRefresh() async {
    Future<List<Category>> categors =
        categoryProvider.fetchAllCategories('1', '10');
    setState(() {
      categories = categors;
    });
  }
}

class CategoryItemArea extends StatelessWidget {
  final Category categoryItem;

  const CategoryItemArea({Key? key, required this.categoryItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (categoryItem.campaigns.isNotEmpty)
      return Container(
        padding: EdgeInsets.only(top: 10.0, bottom: 0.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TitleSubtitleHeading(
            categoryItem.name,
            categoryItem.description,
          ),
          SizedBox(height: 10),
          Column(
            children: [
              for (var campaign in categoryItem.campaigns)
                CampaignListItem(
                  campaign: campaign,
                  onPressed: () {
                    RouterHelper.nextPage(
                        context,
                        CampaignProfileScreen(
                            campaign: campaign, category: categoryItem));
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
                  Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.leftToRight,
                        child: CategoryCampaignScreen(category: categoryItem),
                      ));
                },
              ),
            )
        ]),
      );
    else
      return SizedBox();
  }
}
