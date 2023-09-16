import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';

class UpiPinService with ChangeNotifier {
  OtpFieldController upiPinController = OtpFieldController();

  void addNumber(String number, int position) {
    upiPinController.setValue(number, position);
  }
}
