import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:midowe_app/utils/decorators.dart';
import 'package:midowe_app/utils/helper.dart';
import 'package:midowe_app/utils/validators.dart';
import 'package:midowe_app/views/user_auth/user_register_view.dart';
import 'package:midowe_app/widgets/primary_button_icon.dart';
import 'package:midowe_app/views/user_auth/user_social_login.dart';
import 'package:midowe_app/widgets/text_link_inline.dart';

class UserLoginView extends StatelessWidget {
  final Widget successWidget;

  const UserLoginView({Key? key, required this.successWidget})
      : super(key: key);

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
                        child: LoginForm(
                          successWidget: this.successWidget,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      UserSocialLogin(
                        successWidget: this.successWidget,
                      ),
                      TextLinkInline(
                        text: "Não possui conta?",
                        linkName: "Criar conta",
                        onPressed: () => Helper.nextPage(
                          context,
                          UserRegisterView(
                            successWidget: this.successWidget,
                          ),
                        ),
                      ),
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
  final Widget successWidget;

  const LoginForm({Key? key, required this.successWidget}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  final Map<String, String> formData = {
    'username': '',
    'password': '',
  };

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            validator: validateRequiredField,
            onSaved: (value) => formData['username'] = value ?? '',
            decoration: inputBorderlessRounded(
                "Telefone ou email", FontAwesomeIcons.phoneAlt),
            textInputAction: TextInputAction.next,
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            validator: validateRequiredField,
            onSaved: (value) => formData['password'] = value ?? '',
            decoration:
                inputBorderlessRounded("Password", FontAwesomeIcons.lock),
            onFieldSubmitted: (_) => actionLogin(),
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
              onPressed: () => actionLogin(),
            ),
          )
        ],
      ),
    );
  }

  void actionLogin() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      actionShowLoading();

      try {
        SignInResult result = await Amplify.Auth.signIn(
            username: formData['username'] ?? '',
            password: formData['password'] ?? '');

        if (result.isSignedIn) {
          Helper.nextPageUntilFirst(context, widget.successWidget);
        } else {
          Navigator.pop(context);
        }
      } on AuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 5),
            content: Text(e.message),
          ),
        );
        Navigator.pop(context);
      }
    }
  }

  void actionShowLoading() {
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
                child: Text("Aguarde..."),
              ),
            ],
          ),
        );
      },
    );
  }
}
