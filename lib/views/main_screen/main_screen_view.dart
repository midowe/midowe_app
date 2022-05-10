import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'categories_area.dart';
import 'featured_area.dart';
import 'header_area.dart';

class MainScreenView extends StatelessWidget {
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
