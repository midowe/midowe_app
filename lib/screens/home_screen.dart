import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:midowe_app/components/home_page_campaigns.dart';
import 'package:midowe_app/components/home_page_explore.dart';
import 'package:midowe_app/components/home_page_profile.dart';
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
  late Auth0 auth0;
  int _selectedIndex = 0;
  List<Widget> _pages = <Widget>[HomePageExplore()];

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      HomePageExplore(),
      HomePageCampaigns(),
      HomePageProfile(onLogout: () {
        _onItemTapped(0);
      }),
    ];

    auth0 = Auth0(Constants.AUTH0_DOMAIN, Constants.AUTH0_CLIENT_ID);
  }

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
    if (index > 0) {
      auth0.credentialsManager.hasValidCredentials().then((isLoggedIn) => {
            if (isLoggedIn)
              {
                if (sessionUserSub != "")
                  {
                    setState(() {
                      _selectedIndex = index;
                    })
                  }
                else
                  {
                    auth0.credentialsManager.credentials().then((credentials) =>
                        {_setStateAndUserSub(credentials, index)})
                  }
              }
            else
              {
                auth0.webAuthentication().login().then(
                    (credentials) => {_setStateAndUserSub(credentials, index)})
              }
          });
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _setStateAndUserSub(credentials, int index) {
    sessionUserSub = credentials.user.email;
    setState(() {
      _selectedIndex = index;
    });
  }
}
