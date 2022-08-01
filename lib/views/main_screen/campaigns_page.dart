import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../models/CampaignData.dart';
import '../../providers/campaign_provider.dart';
import '../../utils/constants.dart';
import '../../utils/helper.dart';
import '../../widgets/campaign_list_item.dart';
import '../../widgets/title_subtitle_heading.dart';
import '../campaign_profile/campaign_profile_view.dart';

class CampaignsPage extends StatefulWidget {
  String query;

  CampaignsPage({Key? key, required this.query}) : super(key: key);

  @override
  _ProductsPage createState() => new _ProductsPage();
}

class _ProductsPage extends State<CampaignsPage> {
  final campaignProvider = GetIt.I.get<CampaignProvider>();

  late Future<List<CampaignData>> campaigns;

  TextEditingController seachController = new TextEditingController();
  // = campaignProvider.getCampaignData();

  @override
  void initState() {
    super.initState();
    this.campaigns = campaignProvider.getCampaignData();
    seachController.text = widget.query;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Container(
            height: 90.0,
            child: Stack(
              children: <Widget>[
                AppBar(
                  leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  title: Text("Explorar"),
                  backgroundColor: Constants.primaryColor,
                ),
              ],
            ),
          ),

          SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: new TextField(
              decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide:
                          new BorderSide(color: Constants.primaryBackGround)),
                  hintText: 'Escreva aqui',
                  helperText: 'Pesquise pelo nome da campanha',
                  labelText: 'Campanha',
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  prefixText: ' ',
                  suffixText: 'NOME',
                  suffixStyle: const TextStyle(color: Colors.grey)),
              controller: seachController,
              onChanged: (value) {},
            ),
          ), // Required some widget in between to float AppBar
          SizedBox(
            height: 10,
          ),

          SizedBox(
            height: 20,
          ),
          FutureBuilder<List<CampaignData>>(
              future: campaigns,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isNotEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 20.0, top: 20.0, right: 20.0, bottom: 20.0),
                          child: TitleSubtitleHeading(
                            "Resultado da Pesquisa",
                            "Campanhas encontradas",
                          ),
                        ),
                        for (var campaign in snapshot.data!)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: CampaignListItem(
                              campaign: campaign,
                              onPressed: () {
                                Helper.nextPage(
                                    context,
                                    CampaignProfileView(
                                        campaign: campaign, category: null));
                              },
                            ),
                          ),
                        SizedBox(width: 15),
                      ],
                    );
                  } else {
                    return Container(
                      width: 0,
                      height: 0,
                    );
                  }
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return Container(
                  height: 100,
                );
              })
        ]));
  }
}
