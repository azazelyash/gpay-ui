import 'package:flutter/material.dart';

class AmountService with ChangeNotifier {
  String amount = '';

  setAmount(String value) {
    amount = value;
    notifyListeners();
  }
}
