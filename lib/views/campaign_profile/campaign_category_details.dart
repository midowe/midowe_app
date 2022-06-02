import 'package:flutter/material.dart';

import '../../models/category_model.dart';

class CampaignCategoryDetail extends StatelessWidget {
  final Category? category;

  const CampaignCategoryDetail({Key? key, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 35,
          ),
          Text(
            "Categoria",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            category!.name,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
          ),
          Text(
            category!.description,
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
