import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:midowe_app/utils/constants.dart';
import 'package:midowe_app/widgets/primary_button_icon.dart';
import 'package:midowe_app/widgets/social_share_button.dart';

class UserLoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.arrowLeft,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "Entrar com sua conta",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: _composeFormBody(),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      _composeSocialLogin(),
                      _composeAskToLogin(context)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _composeFormBody() {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              prefixIcon: Icon(
                FontAwesomeIcons.phoneAlt,
                color: Constants.palidGray,
                size: 15,
              ),
              fillColor: Constants.secondaryColor4,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              hintStyle: TextStyle(color: Constants.palidGray),
              filled: true,
              hintText: "Número de telefone"),
        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              prefixIcon: Icon(
                FontAwesomeIcons.lock,
                color: Constants.palidGray,
                size: 15,
              ),
              fillColor: Constants.secondaryColor4,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              hintStyle: TextStyle(color: Constants.palidGray),
              filled: true,
              hintText: "Password"),
        ),
        SizedBox(
          height: 30,
        ),
        SizedBox(
          width: 200,
          child: PrimaryButtonIcon(
            text: "Entrar",
            icon: Icon(CupertinoIcons.arrow_right),
            onPressed: () {},
          ),
        )
      ],
    );
  }

  Widget _composeSocialLogin() {
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
            SocialShareButton(
              icon: Icon(FontAwesomeIcons.facebook),
              onPressed: () {},
            ),
            SocialShareButton(
              icon: Icon(FontAwesomeIcons.google),
              onPressed: () {},
            ),
            SocialShareButton(
              icon: Icon(FontAwesomeIcons.twitter),
              onPressed: () {},
            ),
            SocialShareButton(
              icon: Icon(FontAwesomeIcons.linkedin),
              onPressed: () {},
            )
          ],
        )
      ],
    );
  }

  Widget _composeAskToLogin(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40, bottom: 20),
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
              text: "Não possui conta? ",
              style: TextStyle(color: Colors.black87, fontSize: 15),
            ),
            TextSpan(
                text: "Criar conta",
                style: TextStyle(
                    color: Constants.primaryColor,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    Navigator.pop(context);
                  }),
          ])),
    );
  }
}
