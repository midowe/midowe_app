import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:midowe_app/models/campaign_model.dart';
import 'package:midowe_app/providers/campaign_provider.dart';
import 'package:midowe_app/utils/helper.dart';
import 'package:midowe_app/views/approval_profile_view.dart';
import 'package:midowe_app/widgets/campaign_list_item.dart';
import 'package:midowe_app/widgets/title_subtitle_heading.dart';

class ApprovalListView extends StatelessWidget {
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
                      ApprovalHeader(),
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
                  child: ApprovalList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ApprovalHeader extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ApprovalHeaderState();
}

class _ApprovalHeaderState extends State<ApprovalHeader> {
  final campaignProvider = GetIt.I.get<CampaignProvider>();
  late Future<int> totalPendingApproval;

  @override
  void initState() {
    super.initState();
    this.totalPendingApproval = campaignProvider.countPendingApproval();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: totalPendingApproval,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return TitleSubtitleHeading(
            "Pendentes de aprovação",
            "Possui ${snapshot.data} campanha${snapshot.data != 1 ? 's' : ''} pendente${snapshot.data != 1 ? 's' : ''} de aprovação",
          );
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

class ApprovalList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ApprovalListState();
  }
}

class _ApprovalListState extends State<ApprovalList> {
  static const _pageSize = 10;
  final campaignProvider = GetIt.I.get<CampaignProvider>();

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
      final newItems =
          await campaignProvider.fetchPendingApproval(pageKey, _pageSize);

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
        () => _pagingController.refresh(),
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
