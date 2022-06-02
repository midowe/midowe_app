import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:midowe_app/models/category_model.dart';
import 'package:midowe_app/utils/constants.dart';
import 'package:midowe_app/utils/formatter.dart';

import '../../models/CampaignData.dart';
import '../../providers/category_provider.dart';

class CampaignStats extends StatelessWidget {
  final CampaignData campaign;

  const CampaignStats({Key? key, required this.campaign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: [
          Container(
              child: Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: [
              Text(
                "${campaign.total_donations} apoiantes (${Formatter.currencyDouble((campaign.current_balance.toDouble() * 100) / campaign.target_amount.toDouble())}%) - Meta ${Formatter.currencyDouble(campaign.target_amount.toDouble())}  termina ${campaign.target_date}.",
                style: TextStyle(color: Constants.secondaryColor2),
              ),
            ],
          )),
          /* if (campaign.target_date != '')
            Icon(
              FontAwesomeIcons.calendarAlt,
              size: 18,
            ),
          if (campaign.target_date != '')
            Text(
              "${Formatter.dayMonth(campaign.target_date)}",
              style: TextStyle(color: Constants.primaryColor),
            ),
           */
        ],
      ),
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
