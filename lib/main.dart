import 'package:flutter/material.dart';
import 'package:midowe_app/utils/application_theme.dart';
import 'package:midowe_app/views/welcome_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: applicationTheme(context),
      home: Welcome(),
    );
  }
}
