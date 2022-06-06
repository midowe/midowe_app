import 'dart:convert';

import 'package:midowe_app/models/campaign_pending_model.dart';
import 'package:midowe_app/models/category_model.dart';
import 'package:midowe_app/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import '../models/CampaignData.dart';
import '../models/CampaignImage.dart';
import '../models/FeaturedCampaign.dart';
import '../models/Fundraiser.dart';
import '../models/donation_model.dart';
import '../utils/constants.dart';

class CampaignProvider extends BaseProvider {
  List<FeaturedCampaign> campaigns = [];

  Future<List<FeaturedCampaign>> getAll() async {
    var response = await http.get(Uri.parse(Constants.BASE_URL_CMS +
        "campaigns?fields[0]=title&fields[1]=description&filters[on_spot]=true&populate[images][fields][0]=url"));

    if (response.statusCode == 200) {
      campaigns.clear();
    }
    var decodedData = jsonDecode(response.body)["data"];

    for (var u in decodedData) {
      var url = u['attributes']['images']['data'][0]['attributes']['url'];
      campaigns.add(FeaturedCampaign.fromJson(u['attributes'], u["id"], url));
    }
    return campaigns;
  }

  Future<List<CampaignData>> getCampaignData() async {
    List<CampaignData> campaigns = [];
    var response = await http.get(Uri.parse(Constants.BASE_URL_CMS +
        "campaigns?populate[0]=images&populate[1]=fundraiser&filters[on_spot]=true&sort[1]=createdAt:desc"));

    if (response.statusCode == 200) {
      campaigns.clear();
    }
    var decodedData = jsonDecode(response.body)["data"];

    for (var u in decodedData) {
      var url = u['attributes']['images']['data'][0]['attributes']['url'];
      var images = u['attributes']['images']['data'];
      var fundraiser = u['attributes']['fundraiser']['data'];
      List<CampaignImage> imageList = [];
      for (var i in images) {
        imageList.add(CampaignImage.fromJson(i['attributes']));
      }

      campaigns.add(CampaignData.fromJson(
          u['attributes'],
          u["id"],
          url,
          Fundraiser.fromJson(fundraiser['attributes'], fundraiser['id']),
          imageList));
    }
    return campaigns;
  }

  Future<CampaignData> getOneCampaignData(String id) async {
    var response = await http.get(Uri.parse(Constants.BASE_URL_CMS +
        "campaigns/$id?populate[0]=category&populate[1]=fundraiser&&populate[2]=images"));

    if (response.statusCode == 200) {
      campaigns.clear();
    }
    var decodedData = jsonDecode(response.body)["data"];
    var url =
        decodedData['attributes']['images']['data'][0]['attributes']['url'];
    var images = decodedData['attributes']['images']['data'];
    var fundraiser = decodedData['attributes']['fundraiser']['data'];
    List<CampaignImage> imageList = [];
    for (var i in images) {
      imageList.add(CampaignImage.fromJson(i['attributes']));
    }

    return CampaignData.fromJson(
        decodedData['attributes'],
        decodedData["id"],
        url,
        Fundraiser.fromJson(fundraiser['attributes'], fundraiser['id']),
        imageList);
  }

  Future<List<CampaignData>> fetchFeatured() async {
    List<CampaignData> campains = [
      CampaignData(
          updatedAt: '',
          approved: true,
          current_balance: 2000,
          description: 'ola',
          notes: '',
          on_spot: true,
          total_amount: 0.00,
          verified: true,
          title: '',
          target_amount: 200,
          thank_you_message: 'obrigado',
          id: 1,
          url: '',
          verified_at: '',
          verified_by: '',
          createdAt: '222',
          target_date: '',
          images: [],
          total_donations: 8000),
    ];
    return campains;
  }

  Future<List<Category>> fetchTopByCategory() async {
    return [
      Category(
        id: 1,
        name: 'Saude',
        description: 'Saude, Medicação',
        campaigns: [],
        updatedAt: "",
        createdAt: "",
      ),
    ];
  }

  Future<List<CampaignData>> fetchOfCategory(
    int categoryId,
    int page,
    int pageSize,
  ) async {
    List<CampaignData> campaigns = [];
    var response = await http.get(Uri.parse(Constants.BASE_URL_CMS +
        "campaigns?populate[0]=images&populate[1]=fundraiser&filters[category]=" +
        categoryId.toString() +
        "&sort[1]=createdAt:desc&pagination[page]=" +
        page.toString() +
        "&pagination[pageSize]=" +
        pageSize.toString()));

    if (response.statusCode == 200) {
      campaigns.clear();
    }
    var decodedData = jsonDecode(response.body)["data"];

    for (var u in decodedData) {
      var url = u['attributes']['images']['data'][0]['attributes']['url'];
      var images = u['attributes']['images']['data'];
      var fundraiser = u['attributes']['fundraiser']['data'];
      List<CampaignImage> imageList = [];
      for (var i in images) {
        imageList.add(CampaignImage.fromJson(i['attributes']));
      }

      campaigns.add(CampaignData.fromJson(
          u['attributes'],
          u["id"],
          url,
          Fundraiser.fromJson(fundraiser['attributes'], fundraiser['id']),
          imageList));
    }
    return campaigns;
  }

  Future<List<Donation>> fetchDonationsByCampagn(int campagnId) async {
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
    return List.empty();
  }
}
