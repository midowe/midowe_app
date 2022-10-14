import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/material.dart';

class HomePageCampaigns extends StatefulWidget {
  const HomePageCampaigns({Key? key}) : super(key: key);

  @override
  State<HomePageCampaigns> createState() => _HomePageCampaigns();
}

class _HomePageCampaigns extends State<HomePageCampaigns> {
  Credentials? _credentials;

  late Auth0 auth0;

  @override
  void initState() {
    super.initState();
    auth0 = Auth0('midowe.us.auth0.com', 'JOMO4PLaodA5kzSOephDR8Ynqat4yqWZ');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (_credentials == null)
          ElevatedButton(
              onPressed: () async {
                final credentials = await auth0.webAuthentication().login();

                setState(() {
                  _credentials = credentials;
                });
              },
              child: const Text("Log in"))
        else
          Column(
            children: [
              ProfileView(user: _credentials!.user),
              ElevatedButton(
                  onPressed: () async {
                    await auth0.webAuthentication().logout();

                    setState(() {
                      _credentials = null;
                    });
                  },
                  child: const Text("Log out"))
            ],
          )
      ],
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key, required this.user}) : super(key: key);

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (user.name != null) Text(user.name!),
        if (user.email != null) Text(user.email!)
      ],
    );
  }
}
