import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:midowe_app/providers/campaign_provider.dart';
import 'package:midowe_app/utils/decorators.dart';
import 'package:midowe_app/utils/helper.dart';
import 'package:midowe_app/widgets/campaign_list_item.dart';

import '../models/CampaignData.dart';
import 'campaign_profile/campaign_profile_view.dart';

class CampaignSearchView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CampaignSearchViewState();
}

class _CampaignSearchViewState extends State<CampaignSearchView> {
  static const _pageSize = 10;
  final campaignProvider = GetIt.I.get<CampaignProvider>();
  final seaerchInputController = TextEditingController();

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
      final newItems = await campaignProvider.fetchSearchCampaign(
          seaerchInputController.text, pageKey, _pageSize);

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
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      FontAwesomeIcons.arrowLeft,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) => {_pagingController.refresh()},
                      controller: seaerchInputController,
                      decoration: inputBorderlessRounded(
                          "Pesquise aqui", FontAwesomeIcons.search),
                      textInputAction: TextInputAction.next,
                      autofocus: true,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: RefreshIndicator(
                    onRefresh: () => Future.sync(
                      () => _pagingController.refresh(),
                    ),
                    child: PagedListView<int, CampaignData>(
                      pagingController: _pagingController,
                      builderDelegate: PagedChildBuilderDelegate<CampaignData>(
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
