import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../models/CampaignData.dart';
import '../../providers/campaign_provider.dart';
import 'categories_area.dart';
import 'featured_area.dart';
import 'main_header.dart';

class MainScreenView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainState();
  }
}

class _MainState extends State<MainScreenView> {
  final campaignProvider = GetIt.I.get<CampaignProvider>();
  late Future<List<CampaignData>> campaigns;

  @override
  void initState() {
    super.initState();
    this.campaigns = campaignProvider.getCampaignData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //HeaderArea(),
            MainHeader(),
            RefreshIndicator(
                backgroundColor: Colors.purple,
                color: Colors.white,
                child: Column(children: [
                  FeaturedArea(campaigns: campaigns),
                  CategoriesArea(),
                ]),
                onRefresh: _pullRefresh)
          ],
        ),
      ),
    );
  }

  Future<void> _pullRefresh() async {
    Future<List<CampaignData>> campas = campaignProvider.getCampaignData();
    setState(() {
      campaigns = campas;
    });
  }
}
