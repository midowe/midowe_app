import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:midowe_app/views/user_profile/edit_profile_view.dart';
import 'package:midowe_app/views/user_profile/profile_widget.dart';

import 'button_widget.dart';
import 'numbers_widget.dart';

class UserProfileView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserProfileViewState();
  }
}

class _UserProfileViewState extends State<UserProfileView> {
  late Future<List<AuthUserAttribute>> userAttributes;

  @override
  void initState() {
    super.initState();
    this.userAttributes = Amplify.Auth.fetchUserAttributes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [],
      ),
      body: FutureBuilder<List<AuthUserAttribute>>(
        future: userAttributes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              physics: BouncingScrollPhysics(),
              children: [
                ProfileWidget(
                  imagePath: getUserAttribute(snapshot.data!, 'picture'),
                  onClicked: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => EditProfileView()),
                    );
                  },
                ),
                const SizedBox(height: 24),
                buildName(
                    getUserAttribute(snapshot.data!, 'name'),
                    getUserAttribute(snapshot.data!, 'email'),
                    getUserAttribute(snapshot.data!, 'phone_number')),
                const SizedBox(height: 24),
                NumbersWidget(),
                const SizedBox(height: 35),
                buildAbout(
                    getUserAttribute(snapshot.data!, 'custom:headline'),
                    getUserAttribute(snapshot.data!, 'address'),
                    getUserAttribute(
                        snapshot.data!, 'custom:reallocation_method'),
                    getUserAttribute(
                        snapshot.data!, 'custom:reallocation_address')),
                const SizedBox(height: 24),
                Center(child: buildUpgradeButton()),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  String getUserAttribute(
      List<AuthUserAttribute> authUserAttributes, String keyName) {
    if (authUserAttributes
        .any((element) => element.userAttributeKey == keyName)) {
      return authUserAttributes
          .firstWhere((element) => element.userAttributeKey == keyName)
          .value;
    }
    return '';
  }

  Widget buildName(name, email, phone) => Column(
        children: [
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          if (email != '') const SizedBox(height: 4),
          if (email != '')
            Text(
              email,
              style: TextStyle(color: Colors.grey),
            ),
          if (phone != '') const SizedBox(height: 4),
          if (phone != '')
            Text(
              phone,
              style: TextStyle(color: Colors.grey),
            )
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Terminar a sessão',
        onClicked: () async {
          await Amplify.Auth.signOut();
          Navigator.pop(context);
        },
      );

  Widget buildAbout(
          String headline, address, reallocationMethod, reallocationAddress) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sobre',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text('Titulo/frase de destaque'),
            Text(headline == '' ? '--' : headline,
                style: TextStyle(fontSize: 16, height: 1.4)),
            const SizedBox(height: 16),
            Text('Endereço'),
            Text(address == '' ? '--' : address),
            const SizedBox(height: 16),
            Text('Método de recepção de doações'),
            Text(reallocationMethod == '' ? '--' : reallocationMethod),
            const SizedBox(height: 16),
            Text('Número de recepção de doações'),
            Text(reallocationAddress == '' ? '--' : reallocationAddress),
          ],
        ),
      );
}
