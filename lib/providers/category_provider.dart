import 'dart:convert';

import 'package:midowe_app/models/category_model.dart';
import 'package:midowe_app/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import '../models/CampaignData.dart';
import '../models/CampaignImage.dart';
import '../models/Fundraiser.dart';
import '../utils/constants.dart';

class CategoryProvider extends BaseProvider {
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

  Future<List<Category>> fetchCategoriesfetchCategories() async {
    return [
      Category(
          id: 1,
          name: 'Saude',
          description: 'Saude, Medicação',
          campaigns: campaigns,
          updatedAt: "",
          createdAt: ""),
      Category(
        id: 2,
        name: 'Musca',
        description: 'Musca, Arte, Cultura',
        campaigns: campaigns,
        updatedAt: "",
        createdAt: "",
      ),
      Category(
          id: 2,
          name: 'Projectos',
          description: 'Iniciativas diferenes',
          campaigns: campaigns,
          updatedAt: "",
          createdAt: ""),
    ];
  }

  Future<Category> fetchCategoryById(int categoryId) async {
    return Category(
      id: 2,
      name: 'Saude',
      description: 'Saude, Medicação',
      campaigns: campaigns,
      updatedAt: "",
      createdAt: "",
    );
  }
}
