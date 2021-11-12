import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:midowe_app/utils/helper.dart';
import 'package:midowe_app/widgets/social_icon_button.dart';

class UserSocialLogin extends StatelessWidget {
  final Widget successWidget;

  const UserSocialLogin({Key? key, required this.successWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Ou continue com plataformas sociais",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12),
        ),
        SizedBox(
          height: 10,
        ),
        Wrap(
          spacing: 15.0,
          children: [
            SocialIconButton(
              icon: Icon(FontAwesomeIcons.facebook),
              onPressed: () async {
                try {
                  SignInResult result = await Amplify.Auth.signInWithWebUI(
                      provider: AuthProvider.facebook);

                  if (result.isSignedIn) {
                    Helper.nextPageUntilFirst(context, successWidget);
                  }
                } on AmplifyException catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 5),
                      content: Text(e.message),
                    ),
                  );
                }
              },
            ),
            SocialIconButton(
              icon: Icon(FontAwesomeIcons.google),
              onPressed: () async {
                try {
                  var result = await Amplify.Auth.signInWithWebUI(
                      provider: AuthProvider.google);
                  if (result.isSignedIn) {
                    Helper.nextPageUntilFirst(context, successWidget);
                  }
                } on AmplifyException catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 5),
                      content: Text(e.message),
                    ),
                  );
                }
              },
            ),
          ],
        )
      ],
    );
  }
}
