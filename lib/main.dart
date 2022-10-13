import 'package:flutter/material.dart';
import 'package:midowe_app/helpers/application_theme.dart';
import 'package:midowe_app/helpers/constants.dart';
import 'package:midowe_app/helpers/service_locator.dart';
import 'package:midowe_app/screens/home_screen.dart';
import 'package:midowe_app/screens/welcome_screen.dart';
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
      return HomeScreen();
    }
    FlutterNativeSplash.remove();
    return WelcomeScreen();
  }
}
