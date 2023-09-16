import 'package:flutter/material.dart';

class UpiPinService with ChangeNotifier {
  TextEditingController upiPinController = TextEditingController();
  bool isObscure = true;

  void toggleObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  void addNumber(String number) {
    if (upiPinController.text.length < 4) {
      upiPinController.text += number;
      notifyListeners();
    }
  }

  void removeNumber() {
    if (upiPinController.text.length > 0) {
      upiPinController.text = upiPinController.text.substring(0, upiPinController.text.length - 1);
      notifyListeners();
    }
  }

  bool isUpiPinValid() {
    if (upiPinController.text.length == 4) {
      return true;
    } else {
      return false;
    }
  }

  void clearUpiPin() {
    upiPinController.clear();
    notifyListeners();
  }
}
