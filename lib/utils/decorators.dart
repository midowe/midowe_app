import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'constants.dart';

InputDecoration inputBorderlessRounded(String hintText) {
  return InputDecoration(
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
      hintText: hintText);
}
