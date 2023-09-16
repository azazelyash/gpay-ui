import 'package:flutter/material.dart';
import 'package:gpay_ui/screens/upi_pin_screen/models/tax.model.dart';

class TaxDropDownService with ChangeNotifier {
  List<TaxDropdownItem> taxDropdownList = [
    TaxDropdownItem("ICICI Bank", "1"),
    TaxDropdownItem("HDFC Bank", "1.45"),
    TaxDropdownItem("KOTAK Bank", "1.3"),
    TaxDropdownItem("PSB", "4"),
    TaxDropdownItem("SBI", "2"),
    TaxDropdownItem("BOB", "1.03"),
  ];

  TaxDropdownItem selectedTax = TaxDropdownItem("ICICI Bank", "1");

  setTax(TaxDropdownItem tax) {
    selectedTax = tax;
    notifyListeners();
  }
}
