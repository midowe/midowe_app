import 'dart:convert';

import 'package:midowe_app/models/campaign_model.dart';
import 'package:midowe_app/models/campaign_pending_model.dart';
import 'package:midowe_app/models/category_campaigns.dart';
import 'package:midowe_app/models/category_model.dart';
import 'package:midowe_app/providers/base_provider.dart';
import 'package:http/http.dart' as http;

import '../models/FeaturedCampaign.dart';

class CampaignProvider extends BaseProvider {
  List<FeaturedCampaign> campaigns = [];

  Future<List<FeaturedCampaign>> getAll() async {
    var response = await http.get(Uri.parse(
        "https://cms.dev.midowe.co.mz/api/campaigns?fields[0]=title&fields[1]=description&filters[on_spot]=true&populate[images][fields][0]=url"));

    if (response.statusCode == 200) {
      campaigns.clear();
    }
    var decodedData = jsonDecode(response.body)["data"];

    for (var u in decodedData) {
      var featuredCampaign =
          FeaturedCampaign.fromJson(u['attributes'], u["id"]);
      var url =u['attributes']['images']['data'][0]['attributes']['url'];
      if (url != null) featuredCampaign.url = url;
      campaigns.add(featuredCampaign);
    }
    return campaigns;
  }


  Campaign getOneCampaign() {

    return   Campaign(
        categoryId: 'category1',
        campaignId: 'campaign1',
        userId: 'user1',
        title: 'Medicação para tensão alta e alimentação do bebé',
        content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse est metus, scelerisque consequat turpis in, posuere porta risus.',
        profileImage: 'https://picsum.photos/400/400',
        additionalImages: [
          'https://picsum.photos/405/405',
          'https://picsum.photos/406/406',
          'https://picsum.photos/407/407'
        ],
        targetAmount: 2000,
        targetDate: '2022-10-01',
        approved: true,
        approvedBy: 'admin',
        approvedAt: '2022-01-01',
        totalDonations: 10,
        totalAmount: 20,
        createdAt: '222');
  }
  Future<List<Campaign>> fetchFeatured() async {
    List<Campaign> campains = [
      Campaign(
          categoryId: 'category1',
          campaignId: 'campaign1',
          userId: 'user1',
          title: 'Medicação para tensão alta e alimentação do bebé',
          content:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse est metus, scelerisque consequat turpis in, posuere porta risus.',
          profileImage: 'https://picsum.photos/400/400',
          additionalImages: [
            'https://picsum.photos/405/405',
            'https://picsum.photos/406/406',
            'https://picsum.photos/407/407'
          ],
          targetAmount: 2000,
          targetDate: '2022-10-01',
          approved: true,
          approvedBy: 'admin',
          approvedAt: '2022-01-01',
          totalDonations: 10,
          totalAmount: 20,
          createdAt: '222'),
      Campaign(
          categoryId: 'category1',
          campaignId: 'campaign1',
          userId: 'user1',
          title: 'Ajuda ao bairro de mafalala',
          content:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse est metus, scelerisque consequat turpis in, posuere porta risus.',
          profileImage: 'https://picsum.photos/401/401',
          additionalImages: [],
          targetAmount: 2000,
          targetDate: '2022-10-01',
          approved: true,
          approvedBy: 'admin',
          approvedAt: '2022-01-01',
          totalDonations: 10,
          totalAmount: 20,
          createdAt: '222'),
      Campaign(
          categoryId: 'category1',
          campaignId: 'campaign1',
          userId: 'user1',
          title: 'Musico inicia sua nova carreira',
          content:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse est metus, scelerisque consequat turpis in, posuere porta risus.',
          profileImage: 'https://picsum.photos/403/403',
          additionalImages: [],
          targetAmount: 2000,
          targetDate: '2022-10-01',
          approved: true,
          approvedBy: 'admin',
          approvedAt: '2022-01-01',
          totalDonations: 10,
          totalAmount: 20,
          createdAt: '222'),
    ];
    return campains;
  }

  Future<List<CategoryCampaigns>> fetchTopByCategory() async {
    return [
      CategoryCampaigns(
          category: Category(
              id: 'saude',
              name: 'Saude',
              description: 'Saude, Medicação',
              requireApproval: false),
          campaigns: [
            Campaign(
                categoryId: 'category1',
                campaignId: 'campaign1',
                userId: 'user1',
                title: 'Medicação para tensão alta e alimentação do bebé',
                content:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse est metus, scelerisque consequat turpis in, posuere porta risus.',
                profileImage: 'https://picsum.photos/400/400',
                additionalImages: [
                  'https://picsum.photos/405/405',
                  'https://picsum.photos/406/406',
                  'https://picsum.photos/407/407'
                ],
                targetAmount: 2000,
                targetDate: '2022-10-01',
                approved: true,
                approvedBy: 'admin',
                approvedAt: '2022-01-01',
                totalDonations: 10,
                totalAmount: 20,
                createdAt: '222'),
            Campaign(
                categoryId: 'category1',
                campaignId: 'campaign1',
                userId: 'user1',
                title: 'Ajuda ao bairro de mafalala',
                content:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse est metus, scelerisque consequat turpis in, posuere porta risus.',
                profileImage: 'https://picsum.photos/401/401',
                additionalImages: [],
                targetAmount: 2000,
                targetDate: '2022-10-01',
                approved: true,
                approvedBy: 'admin',
                approvedAt: '2022-01-01',
                totalDonations: 10,
                totalAmount: 20,
                createdAt: '222'),
          ])
    ];
  }

  Future<List<Campaign>> fetchOfCategory(
    String categoryId,
    String lastCampaignId,
  ) async {
    return [
      Campaign(
          categoryId: 'category1',
          campaignId: 'campaign1',
          userId: 'user1',
          title: 'Medicação para tensão alta e alimentação do bebé',
          content:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse est metus, scelerisque consequat turpis in, posuere porta risus.',
          profileImage: 'https://picsum.photos/400/400',
          additionalImages: [
            'https://picsum.photos/405/405',
            'https://picsum.photos/406/406',
            'https://picsum.photos/407/407'
          ],
          targetAmount: 2000,
          targetDate: '2022-10-01',
          approved: true,
          approvedBy: 'admin',
          approvedAt: '2022-01-01',
          totalDonations: 10,
          totalAmount: 20,
          createdAt: '222'),
      Campaign(
          categoryId: 'category1',
          campaignId: 'campaign1',
          userId: 'user1',
          title: 'Ajuda ao bairro de mafalala',
          content:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse est metus, scelerisque consequat turpis in, posuere porta risus.',
          profileImage: 'https://picsum.photos/401/401',
          additionalImages: [],
          targetAmount: 2000,
          targetDate: '2022-10-01',
          approved: true,
          approvedBy: 'admin',
          approvedAt: '2022-01-01',
          totalDonations: 10,
          totalAmount: 20,
          createdAt: '222'),
      Campaign(
          categoryId: 'category1',
          campaignId: 'campaign1',
          userId: 'user1',
          title: 'Musico inicia sua nova carreira',
          content:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse est metus, scelerisque consequat turpis in, posuere porta risus.',
          profileImage: 'https://picsum.photos/403/403',
          additionalImages: [],
          targetAmount: 2000,
          targetDate: '2022-10-01',
          approved: true,
          approvedBy: 'admin',
          approvedAt: '2022-01-01',
          totalDonations: 10,
          totalAmount: 20,
          createdAt: '222'),
    ];
  }

  Future<CampaignPending> fetchPendingApproval(
    String lastCategoryId,
    String lastCampaignId,
  ) async {
    return CampaignPending(0, List.empty());
  }

  Future<List<Campaign>> fetchSearchCampaign(
    String keyword,
    int pageKey,
    int pageSize,
  ) async {
    return List.empty();
  }
}
