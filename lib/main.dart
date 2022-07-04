import 'package:flutter/material.dart';
import 'package:midowe_app/utils/application_theme.dart';
import 'package:midowe_app/utils/constants.dart';
import 'package:midowe_app/utils/service_locator.dart';
import 'package:midowe_app/views/main_screen/main_screen_view.dart';
import 'package:midowe_app/views/welcome_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();
    //_configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: applicationTheme(context),
      home: FutureBuilder<Widget>(
        future: _getMainView(),
        builder: (context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!;
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Future<Widget> _getMainView() async {
    final prefs = await SharedPreferences.getInstance();
    bool? accepted = prefs.getBool(Constants.PREF_ACCEPTED_TERMS);
    if (accepted != null && accepted) {
      FlutterNativeSplash.remove();
      return MainScreenView();
    }
    FlutterNativeSplash.remove();
    return WelcomeView();
  }

/*  void _configureAmplify() async {
    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
    await Amplify.addPlugins([authPlugin]);

    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      print(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }*/
}
