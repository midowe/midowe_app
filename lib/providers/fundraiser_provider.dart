import 'dart:convert';

import 'package:midowe_app/models/fundraiser.dart';
import 'package:midowe_app/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class FundraiserProvider extends BaseProvider {
  Future<Fundraiser> fetchFundraiserByCampaignId(int campaignId) async {
    var response = await http.get(Uri.parse(
        "https://cms.dev.midowe.co.mz/api/fundraisers?filters[campaigns]=" +
            campaignId.toString() +
            "&populate[picture][fields][1]=url"));

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
