import 'dart:convert';

import 'package:midowe_app/models/category_model.dart';
import 'package:http/http.dart' as http;
import '../models/campaign_data.dart';
import '../models/campaign_image.dart';
import '../models/fundraiser.dart';
import '../helpers/constants.dart';

class CategoryProvider {
  List<CampaignData> campaigns = [];

  Future<List<Category>> fetchAllCategories(
      String page, String pageSize) async {
    List<Category> categories = [];
    var response = await http.get(Uri.parse(Constants.BASE_URL_CMS +
        "categories?populate[0]=campaigns&populate[1]=campaigns.images&populate[2]=campaigns.fundraiser&sort[1]=createdAt:desc&pagination[page]=" +
        page +
        "&pagination[pageSize]=" +
        pageSize));

    if (response.statusCode == 200) {
      categories.clear();
    }
    var decodedData = jsonDecode(response.body)["data"];

    for (var u in decodedData) {
      var campaigns = u['attributes']['campaigns']['data'];
      List<CampaignData> campaignsList = [];

      for (var c in campaigns) {
        var images = c['attributes']['images']['data'];
        var fundraiser = c['attributes']['fundraiser']['data'];
        List<CampaignImage> imageList = [];
        for (var i in images) {
          imageList.add(CampaignImage.fromJson(i['attributes']));
        }

        campaignsList.add(CampaignData.fromJson(
            c['attributes'],
            c["id"],
            Fundraiser.fromJson(fundraiser['attributes'], fundraiser['id']),
            imageList));
      }
      categories
          .add(Category.fromJson(u['attributes'], u["id"], campaignsList));
    }
    return categories;
  }
}
