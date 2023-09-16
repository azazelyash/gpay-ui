import 'package:flutter/material.dart';

class DropdownService with ChangeNotifier {
  var accountDropdownList = [
    "1234 **** **** 6587",
    "6588 **** **** 4572",
    "4236 **** **** 5683",
    "7853 **** **** 4897",
    "4156 **** **** 9856",
  ];
  var selectedAccount = "1234 **** **** 6587";

  setBankAccount(String account) {
    selectedAccount = account;
    notifyListeners();
  }
}
