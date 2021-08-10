import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData applicationTheme(BuildContext context) {
  return Theme.of(context).copyWith(
    textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Poppins'),
    primaryTextTheme: Theme.of(context).textTheme.apply(fontFamily: 'Poppins'),
    accentTextTheme: Theme.of(context).textTheme.apply(fontFamily: 'Poppins'),
    primaryColor: Constants.primaryColor,
  );
}
