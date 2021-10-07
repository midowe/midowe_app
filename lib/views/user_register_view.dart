import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:midowe_app/utils/decorators.dart';
import 'package:midowe_app/utils/helper.dart';
import 'package:midowe_app/utils/validators.dart';
import 'package:midowe_app/views/campaign_register_view.dart';
import 'package:midowe_app/views/user_login_view.dart';
import 'package:midowe_app/widgets/primary_button_icon.dart';
import 'package:midowe_app/widgets/social_login_buttons.dart';
import 'package:midowe_app/widgets/text_link_inline.dart';

class UserRegisterView extends StatelessWidget {
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
                        "Criar uma conta",
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
                        child: _RegisterForm(),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      SocialLoginButtons(),
                      TextLinkInline(
                        text: "Já possui uma conta?",
                        linkName: "Entrar",
                        onPressed: () =>
                            Helper.nextPage(context, UserLoginView()),
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

class _RegisterForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  //final _userService = GetIt.I.get<UserService>();
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'fullName': null,
    'phone': null,
    'email': null,
    'password': null
  };

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: validateRequiredField,
            onSaved: (value) => _formData['fullName'] = value,
            decoration:
                inputBorderlessRounded("Nome completo", FontAwesomeIcons.user),
            textInputAction: TextInputAction.next,
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            validator: validateRequiredField,
            onSaved: (value) => _formData['phone'] = value,
            decoration: inputBorderlessRounded(
                "Numero de telefone", FontAwesomeIcons.phoneAlt),
            textInputAction: TextInputAction.next,
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            validator: validateRequiredField,
            onSaved: (value) => _formData['email'] = value,
            decoration:
                inputBorderlessRounded("E-mail", FontAwesomeIcons.envelope),
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
            onFieldSubmitted: (_) => _actionRegister(),
            obscureText: true,
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 200,
            child: PrimaryButtonIcon(
              text: "Criar conta",
              icon: Icon(CupertinoIcons.arrow_right),
              onPressed: () {
                _actionRegister();
              },
            ),
          )
        ],
      ),
    );
  }

  void _actionRegister() {
    print('submiting form');
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _showLoading();
      /*_userService
          .register(_formData['fullName'], _formData['phone'],
              _formData['email'], _formData['password'])
          .then(
            (authResponse) => {
              if (authResponse.success)
                {
                  Helper.nextPage(context, CampaignRegisterView())
                  //Redirect to success
                }
              else
                {
                  authResponse.messages.forEach((message) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(message)));
                  })
                }
            },
          )
          .whenComplete(() => _hideLoading());*/
    }
  }

  void _showLoading() {
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
  }

  void _hideLoading() {
    Navigator.pop(context);
  }
}
