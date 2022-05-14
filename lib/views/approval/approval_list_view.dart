import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:midowe_app/models/campaign_model.dart';
import 'package:midowe_app/models/campaign_pending_model.dart';
import 'package:midowe_app/providers/campaign_provider.dart';
import 'package:midowe_app/utils/helper.dart';
import 'package:midowe_app/views/approval/approval_profile_view.dart';
import 'package:midowe_app/widgets/campaign_list_item.dart';
import 'package:midowe_app/widgets/title_subtitle_heading.dart';

import '../../models/CampaignData.dart';

class ApprovalListView extends StatelessWidget {
  final CampaignPending campaignPending;

  const ApprovalListView({Key? key, required this.campaignPending})
      : super(key: key);

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
                        "Pendentes de aprovação",
                        "Lista campanhas pendentes de aprovação",
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
                  child: ApprovalList(
                    campaignPending: this.campaignPending,
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

class ApprovalList extends StatefulWidget {
  final CampaignPending campaignPending;

  const ApprovalList({Key? key, required this.campaignPending})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ApprovalListState();
  }
}

class _ApprovalListState extends State<ApprovalList> {
  static const _pageSize = 10;
  final campaignProvider = GetIt.I.get<CampaignProvider>();
  CampaignData? _lastCampaign;
  bool firstLoad = true;

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

      var newItems = CampaignPending(0, List.empty());

      if (pageKey == 0 &&
          firstLoad &&
          widget.campaignPending.items.isNotEmpty) {
        newItems = widget.campaignPending;
      } else {
        newItems = await campaignProvider.fetchPendingApproval(
            _lastCampaign != null ? _lastCampaign!.id : 0,
            _lastCampaign != null ? _lastCampaign!.title : "");
      }

      if (newItems.items.isNotEmpty) {
        _lastCampaign = newItems.items.last;
      }

      final isLastPage = newItems.items.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems.items);
      } else {
        final int nextPageKey = pageKey + newItems.items.length;
        _pagingController.appendPage(newItems.items, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    } finally {
      firstLoad = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
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
                          ApprovalProfileView(
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
