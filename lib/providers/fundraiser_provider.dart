import 'dart:convert';

import 'package:midowe_app/helpers/constants.dart';
import 'package:midowe_app/models/fundraiser.dart';
import 'package:http/http.dart' as http;

class FundraiserProvider {
  Future<Fundraiser> fetchFundraiserByCampaignId(int campaignId) async {
    var response = await http.get(Uri.parse(Constants.BASE_URL_CMS +
        "fundraisers?filters[campaigns]=" +
        campaignId.toString() +
        "&populate[picture][fields][1]=url"));

    return _composeFirstFundraiserFromList(response);
  }

  Future<Fundraiser> fetchFundraiserUsername(String username) async {
    var response = await http.get(Uri.parse(Constants.BASE_URL_CMS +
        "fundraisers?filters[username]=$username&populate[picture][fields][1]=url"));

    return _composeFirstFundraiserFromList(response);
  }

  Fundraiser _composeFirstFundraiserFromList(http.Response response) {
    var fundraiser;
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body)["data"];
      for (var f in decodedData) {
        var url = f['attributes']['picture']['data']['attributes']['url'];
        fundraiser =
            Fundraiser.fromJsonWithPicture(f['attributes'], f["id"], url);
      }
    }

    return fundraiser;
  }
}
