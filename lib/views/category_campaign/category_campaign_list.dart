import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:midowe_app/models/campaign_model.dart';
import 'package:midowe_app/models/category_model.dart';
import 'package:midowe_app/providers/campaign_provider.dart';
import 'package:midowe_app/utils/helper.dart';
import 'package:midowe_app/views/campaign_profile_view.dart';
import 'package:midowe_app/widgets/campaign_list_item.dart';

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
  Campaign? _lastCampaign;

  final PagingController<int, Campaign> _pagingController =
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
          widget.category.id,
          _lastCampaign != null ? _lastCampaign!.campaignId : "");

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
      child: PagedListView<int, Campaign>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Campaign>(
          itemBuilder: (context, item, index) {
            return CampaignListItem(
                campaign: item,
                onPressed: () => {
                      Helper.nextPage(
                          context,
                          CampaignProfileView(
                            campaign: item,
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
