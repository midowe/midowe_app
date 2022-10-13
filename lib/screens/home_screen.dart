import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:midowe_app/components/home_page_campaigns.dart';
import 'package:midowe_app/helpers/constants.dart';
import 'package:midowe_app/models/campaign_data.dart';
import 'package:midowe_app/providers/campaign_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final campaignProvider = GetIt.I.get<CampaignProvider>();
  late Future<List<CampaignData>> campaigns;
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    HomePageCampaigns(),
    Icon(
      Icons.camera,
      size: 150,
    ),
    Icon(
      Icons.chat,
      size: 150,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.heart),
              label: 'Explorar',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.square_favorites_alt),
              label: 'Campanhas',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled),
              label: 'Perfil',
            ),
          ],
          selectedItemColor: Constants.primaryColor,
          currentIndex: _selectedIndex, //New
          onTap: _onItemTapped),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
