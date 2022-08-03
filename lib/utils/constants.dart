import 'package:flutter/material.dart';

class Constants {
  Constants._();

  // Colors
  static const Color primaryColor = Color.fromRGBO(95, 46, 234, 1.0);
  static const Color primaryColor1 = Color.fromRGBO(71, 148, 255, 0.2);
  static const Color primaryColor2 = Color.fromRGBO(71, 148, 255, 0.3);

  static const Color secondaryColor = Color.fromRGBO(33, 45, 82, 1);
  static const Color primaryBackGround = Color.fromRGBO(248, 248, 248, 1);
  static const Color secondaryColor1 = Color.fromRGBO(63, 58, 79, 1.0);
  static const Color secondaryColor2 = Color.fromRGBO(144, 143, 203, 1.0);
  static const Color secondaryColor3 = Color.fromRGBO(239, 240, 246, 1.0);
  static const Color secondaryColor4 = Color.fromRGBO(231, 227, 238, 1.0);
  static const Color palidGray = Color.fromRGBO(112, 112, 112, 1.0);

  // DEV
  static const String BASE_URL_CMS = "https://cms.dev.midowe.co.mz/api/";
  static const String BASE_URL_WEB = "https://web.dev.midowe.co.mz/";
  static const String BASE_URL_ACCOUNTING =
      "https://eugqgyjdksk2hoi7rj6b23zjti0grskw.lambda-url.af-south-1.on.aws";

  // PRD
  // static const String BASE_URL_CMS = "https://cms.midowe.co.mz/api/";
  // static const String BASE_URL_WEB = "https://web.midowe.co.mz/";
  // static const String BASE_URL_ACCOUNTING =
  //     "https://xlhofsmgf4o3xtpleqam77sd240braxu.lambda-url.af-south-1.on.aws";

  // Shared preferences
  static const String PREF_ACCEPTED_TERMS = "pref.accepted.terms";
}
