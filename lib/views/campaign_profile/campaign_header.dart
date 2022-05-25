import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:midowe_app/models/campaign_model.dart';
import 'package:midowe_app/models/category_model.dart';
import 'package:midowe_app/providers/category_provider.dart';
import 'package:midowe_app/utils/constants.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../models/CampaignData.dart';
import '../../models/FeaturedCampaign.dart';

class CampaignHeader extends StatelessWidget {
  final CampaignData campaign;
  final Category? category;

  const CampaignHeader({Key? key, required this.campaign, this.category})
      : super(key: key);

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
                image: campaign.url,
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
            ),

            if(campaign.verified)
            Positioned(
              top: 45,
              right: 15,
              child: IconButton(
                icon: Icon(
                  FontAwesomeIcons.checkCircle,
                ),
                color: Constants.secondaryColor3,
                onPressed: () {
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
                            if (this.category == null)
                              CategoryNameArea(categoryId: campaign.id),
                            if (this.category != null)
                              Text(this.category!.name),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      )), 
                  


                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

class CategoryNameArea extends StatefulWidget {
  final int categoryId;

  const CategoryNameArea({Key? key, required this.categoryId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CategoryNameAreaState();
  }
}

class _CategoryNameAreaState extends State<CategoryNameArea> {
  final categoryProvider = GetIt.I.get<CategoryProvider>();
  late Future<Category> category;

  @override
  void initState() {
    super.initState();
    this.category = categoryProvider.fetchCategoryById(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Category>(
      future: category,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.name);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return Text("...");
      },
    );
  }
}
