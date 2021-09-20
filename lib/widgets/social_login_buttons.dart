import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:midowe_app/widgets/social_icon_button.dart';

class SocialLoginButtons extends StatelessWidget {
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
              onPressed: () {},
            ),
            SocialIconButton(
              icon: Icon(FontAwesomeIcons.google),
              onPressed: () {},
            ),
            SocialIconButton(
              icon: Icon(FontAwesomeIcons.twitter),
              onPressed: () {},
            ),
            SocialIconButton(
              icon: Icon(FontAwesomeIcons.linkedin),
              onPressed: () {},
            )
          ],
        )
      ],
    );
  }
}
