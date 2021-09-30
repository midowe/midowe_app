import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:midowe_app/providers/user_provider.dart';
import 'package:midowe_app/utils/decorators.dart';
import 'package:midowe_app/utils/validators.dart';
import 'package:midowe_app/widgets/primary_button_icon.dart';
import 'package:midowe_app/widgets/social_login_buttons.dart';
import 'package:midowe_app/widgets/text_link_inline.dart';

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
                      TextLinkInline(
                        text: "Não possui conta?",
                        linkName: "Criar conta",
                        onPressed: () => Navigator.pop(context),
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
  final _userProvider = GetIt.I.get<UserProvider>();
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {'identifier': null, 'password': null};

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: validateRequiredField,
            onSaved: (value) => _formData['identifier'] = value,
            decoration: inputBorderlessRounded(
                "Telefone ou email", FontAwesomeIcons.phoneAlt),
            textInputAction: TextInputAction.next,
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            validator: validateRequiredField,
            onSaved: (value) => _formData['password'] = value,
            decoration:
                inputBorderlessRounded("Password", FontAwesomeIcons.lock),
            onFieldSubmitted: (_) => _actionLogin(),
            obscureText: true,
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

  void _actionLogin() {
    print('submiting form');
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _actionShowLoading();
      _userProvider.login(_formData['identifier'], _formData['password']).then(
            (value) => {print('Finished login')},
          );
    }
  }

  void _actionShowLoading() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: new Row(
            children: [
              CircularProgressIndicator(),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text("Processando..."),
              ),
            ],
          ),
        );
      },
    );

    new Future.delayed(new Duration(seconds: 3), () {
      Navigator.pop(context); //pop dialog
    });
  }
}
