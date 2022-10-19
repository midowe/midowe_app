import 'dart:convert';

import 'package:midowe_app/models/campaign_pending_model.dart';
import 'package:http/http.dart' as http;
import '../models/campaign_data.dart';
import '../models/campaign_image.dart';
import '../models/fundraiser.dart';
import '../models/donation_model.dart';
import '../helpers/constants.dart';

class CampaignProvider {
  Future<List<CampaignData>> getTrendingCampaigns() async {
    var response = await http.get(Uri.parse(Constants.BASE_URL_CMS +
        "campaigns?populate[0]=images&populate[1]=fundraiser&filters[on_spot]=true&filters[approved]=true&sort[1]=createdAt:desc"));

    return _composeCampaignList(response);
  }

  Future<List<CampaignData>> listCampaignsOfCategory(
    int categoryId,
    int page,
    int pageSize,
  ) async {
    var response = await http.get(Uri.parse(Constants.BASE_URL_CMS +
        "campaigns?populate[0]=images&populate[1]=fundraiser&filters[category]=" +
        categoryId.toString() +
        "&sort[1]=createdAt:desc&pagination[page]=" +
        page.toString() +
        "&pagination[pageSize]=" +
        pageSize.toString()));

    return _composeCampaignList(response);
  }

  Future<List<CampaignData>> listCampaignsOfFundraiser(
    String username,
  ) async {
    var response = await http.get(Uri.parse(Constants.BASE_URL_CMS +
        "campaigns?populate[0]=images&populate[1]=fundraiser&filters[fundraiser][username]=$username&sort[1]=createdAt:desc"));

    return _composeCampaignList(response);
  }

  Future<List<Donation>> listDonationsOfCampaign(int campagnId) async {
    List<Donation> donations = [];
    var response = await http.get(Uri.parse(
        Constants.BASE_URL_CMS + "donations?filters[campaign]=$campagnId"));

    if (response.statusCode == 200) {
      donations.clear();
      var decodedData = jsonDecode(response.body)["data"];

      for (var u in decodedData) {
        var donation = Donation.fromJson(u['attributes'], u['id']);
        donations.add(donation);
      }
    }
    return donations;
  }

  Future<CampaignPending> fetchPendingApproval(
    int lastCategoryId,
    String lastCampaignId,
  ) async {
    return CampaignPending(0, List.empty());
  }

  Future<List<CampaignData>> fetchSearchCampaign(
    String keyword,
    int pageKey,
    int pageSize,
  ) async {
    var response = await http.get(Uri.parse(Constants.BASE_URL_CMS +
        "campaigns?populate[0]=images&populate[1]=fundraiser&filters[title][\$containsi]=" +
        keyword +
        "&sort[1]=createdAt:desc&pagination[page]=" +
        pageKey.toString() +
        "&pagination[pageSize]=" +
        pageSize.toString()));

    return _composeCampaignList(response);
  }

  List<CampaignData> _composeCampaignList(http.Response response) {
    List<CampaignData> campaigns = [];

    var decodedData = jsonDecode(response.body)["data"];

    for (var u in decodedData) {
      var images = u['attributes']['images']['data'];
      var fundraiser = u['attributes']['fundraiser']['data'];
      List<CampaignImage> imageList = [];
      for (var i in images) {
        imageList.add(CampaignImage.fromJson(i['attributes']));
      }

      campaigns.add(CampaignData.fromJson(
          u['attributes'],
          u["id"],
          Fundraiser.fromJson(fundraiser['attributes'], fundraiser['id']),
          imageList));
    }
    return campaigns;
  }
}
