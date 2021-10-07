import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:midowe_app/models/campaign_model.dart';
import 'package:midowe_app/models/category_model.dart';
import 'package:midowe_app/providers/campaign_provider.dart';
import 'package:midowe_app/providers/category_provider.dart';
import 'package:midowe_app/utils/constants.dart';
import 'package:midowe_app/utils/helper.dart';
import 'package:midowe_app/views/approval_list_view.dart';
import 'package:midowe_app/views/campaign_profile_view.dart';
import 'package:midowe_app/views/category_campaign_view.dart';
import 'package:midowe_app/views/user_register_view.dart';
import 'package:midowe_app/widgets/campaign_list_item.dart';
import 'package:midowe_app/widgets/primary_button_icon.dart';
import 'package:midowe_app/widgets/title_subtitle_heading.dart';
import 'package:transparent_image/transparent_image.dart';

class CampaignListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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

class FeaturedArea extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FeaturedAreaState();
  }
}

class _FeaturedAreaState extends State<FeaturedArea> {
  final campaignProvider = GetIt.I.get<CampaignProvider>();
  late Future<List<Campaign>> campaigns;

  @override
  void initState() {
    super.initState();
    this.campaigns = campaignProvider.fetchFeatured();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Campaign>>(
        future: campaigns,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return Column(
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

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class FeaturedItem extends StatelessWidget {
  final Campaign campaign;

  const FeaturedItem({Key? key, required this.campaign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Helper.nextPage(context, CampaignProfileView(campaign: campaign));
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
                        image: campaign.image,
                      ).image),
                  borderRadius: BorderRadius.all(Radius.circular(25))),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              campaign.title,
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
    this.categories = categoryProvider.fetchCategories();
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
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var category in snapshot.data!)
                    CategoryItemArea(category: category)
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

class CategoryItemArea extends StatefulWidget {
  final Category category;

  const CategoryItemArea({Key? key, required this.category}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CategoryItemAreaState();
  }
}

class _CategoryItemAreaState extends State<CategoryItemArea> {
  final campaignProvider = GetIt.I.get<CampaignProvider>();
  late Future<List<Campaign>> campaigns;

  @override
  void initState() {
    super.initState();
    this.campaigns = campaignProvider.fetchTopOfCategory(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Campaign>>(
      future: campaigns,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty) {
            return Container(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleSubtitleHeading(
                      widget.category.name,
                      widget.category.description,
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: [
                        for (var campaign in snapshot.data!)
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
                    if (snapshot.data!.length > 1)
                      Center(
                        child: IconButton(
                          icon: Icon(
                            CupertinoIcons.chevron_compact_down,
                          ),
                          onPressed: () {
                            Helper.nextPage(
                                context,
                                CategoryCampaignView(
                                    category: widget.category));
                          },
                        ),
                      )
                  ]),
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

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
