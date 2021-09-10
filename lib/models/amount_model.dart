import 'package:flutter/material.dart';

class AmountModel extends ChangeNotifier {
  int _amount = 100;

  set amount(int amount) {
    _amount = amount;
    notifyListeners();
  }

  int get amount {
    return _amount;
  }
}
