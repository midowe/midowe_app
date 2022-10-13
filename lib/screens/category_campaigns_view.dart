import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:midowe_app/components/campaign_list_item.dart';
import 'package:midowe_app/components/title_subtitle_heading.dart';
import 'package:midowe_app/helpers/router_helper.dart';
import 'package:midowe_app/models/category_model.dart';
import 'package:midowe_app/providers/campaign_provider.dart';
import 'package:midowe_app/screens/campaign_profile_screen.dart';

import '../models/campaign_data.dart';

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

class CategoryCampaignList extends StatefulWidget {
  final Category category;

  const CategoryCampaignList({Key? key, required this.category})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CategoryCampaignListState();
  }
}

class _CategoryCampaignListState extends State<CategoryCampaignList> {
  static const _pageSize = 10;
  final campaignProvider = GetIt.I.get<CampaignProvider>();
  CampaignData? _lastCampaign;

  final PagingController<int, CampaignData> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      if (pageKey == 0) {
        _lastCampaign = null;
      }
      final newItems = await campaignProvider.fetchOfCategory(
          widget.category.id, pageKey, 10);

      if (newItems.isNotEmpty) {
        _lastCampaign = newItems.last;
      }

      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future.sync(
        () => {_pagingController.refresh()},
      ),
      child: PagedListView<int, CampaignData>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<CampaignData>(
          itemBuilder: (context, item, index) {
            return CampaignListItem(
                campaign: item,
                onPressed: () => {
                      RouterHelper.nextPage(
                          context,
                          CampaignProfileScreen(
                            campaign: item,
                            category: widget.category,
                          ))
                    });
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
