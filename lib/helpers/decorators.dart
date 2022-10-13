import 'package:flutter/material.dart';

import 'constants.dart';

InputDecoration inputBorderlessRounded(String hintText, IconData iconData) {
  return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      prefixIcon: Icon(
        iconData,
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
