import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:midowe_app/utils/constants.dart';
import 'package:midowe_app/utils/decorators.dart';
import 'package:midowe_app/utils/validators.dart';
import 'package:midowe_app/widgets/primary_button_icon.dart';
import 'package:midowe_app/widgets/social_login_buttons.dart';

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
                        child: LoginForm(),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      SocialLoginButtons(),
                      Container(
                        padding: EdgeInsets.only(top: 40, bottom: 20),
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Não possui conta? ",
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 15),
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
                      )
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
}

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: validateRequiredField,
            decoration: inputBorderlessRounded("Telefone ou email"),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            validator: validateRequiredField,
            obscureText: true,
            decoration: inputBorderlessRounded("Password"),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 200,
            child: PrimaryButtonIcon(
              text: "Entrar",
              icon: Icon(CupertinoIcons.arrow_right),
              onPressed: () => _actionLogin(),
            ),
          )
        ],
      ),
    );
  }

  void _actionLogin() {}
}
