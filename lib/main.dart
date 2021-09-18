import 'package:flutter/material.dart';
import 'package:midowe_app/utils/application_theme.dart';
import 'package:midowe_app/utils/constants.dart';
import 'package:midowe_app/views/campaign_list_view.dart';
import 'package:midowe_app/views/welcome_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: applicationTheme(context),
      home: FutureBuilder<Widget>(
        future: _getMainView(),
        builder: (context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!;
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Future<Widget> _getMainView() async {
    final prefs = await SharedPreferences.getInstance();
    bool? accepted = prefs.getBool(Constants.PREF_ACCEPTED_TERMS);
    if (accepted != null && accepted) {
      return CampaignListView();
    }
    return Welcome();
  }
}
