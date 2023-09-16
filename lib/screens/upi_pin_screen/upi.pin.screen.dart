import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gpay_ui/constants.dart';
import 'package:gpay_ui/screens/success_screen/success.screen.dart';
import 'package:gpay_ui/screens/upi_pin_screen/components/upi.number.button.dart';
import 'package:gpay_ui/screens/upi_pin_screen/components/upi.special.button.dart';
import 'package:gpay_ui/screens/upi_pin_screen/models/tax.model.dart';
import 'package:gpay_ui/screens/upi_pin_screen/provider/dropdown.service.dart';
import 'package:gpay_ui/screens/upi_pin_screen/provider/upi.pin.provider.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

class UpiPinScreen extends StatefulWidget {
  const UpiPinScreen({super.key});

  @override
  State<UpiPinScreen> createState() => _UpiPinScreenState();
}

class _UpiPinScreenState extends State<UpiPinScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: kUpiPinColor,
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text(
          "ICICI Bank",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Image(
            image: AssetImage('assets/images/upi_logo.png'),
            width: 150,
          ),
        ],
      ),
      body: Column(
        children: [
          Consumer<TaxDropDownService>(builder: (context, value, child) {
            return Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                color: Color(
                  0xff1b317d,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<TaxDropdownItem>(
                  value: value.selectedTax,
                  isExpanded: true,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                  elevation: 4,
                  dropdownColor: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  onChanged: (TaxDropdownItem? v) {
                    value.setTax(v!);
                  },
                  selectedItemBuilder: (context) {
                    return value.taxDropdownList.map<Widget>((TaxDropdownItem item) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            "₹ ${item.price}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      );
                    }).toList();
                  },
                  items: value.taxDropdownList.map<DropdownMenuItem<TaxDropdownItem>>((TaxDropdownItem val) {
                    return DropdownMenuItem<TaxDropdownItem>(
                        value: val,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(val.name),
                            Text(val.price, style: const TextStyle(color: Colors.black)),
                          ],
                        ));
                  }).toList(),
                ),
              ),
            );
          }),
          Expanded(
            child: Consumer<UpiPinService>(
              builder: (context, value, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  "Enter UPI PIN",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  splashRadius: 25,
                                  icon: const Icon(
                                    Icons.remove_red_eye,
                                    color: kUpiPinColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: OTPTextField(
                                length: 6,
                                width: MediaQuery.of(context).size.width / 1.4,
                                fieldWidth: 40,
                                keyboardType: TextInputType.none,
                                style: const TextStyle(fontSize: 17),
                                textFieldAlignment: MainAxisAlignment.spaceAround,
                                fieldStyle: FieldStyle.underline,
                                controller: value.upiPinController,
                                onCompleted: (pin) {
                                  print("Completed: " + pin);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            UpiPinButton(
                              text: "1",
                              onTap: () {
                                value.addNumber("1", 1);
                              },
                            ),
                            UpiPinButton(text: "2", onTap: () {}),
                            UpiPinButton(text: "3", onTap: () {}),
                          ],
                        ),
                        Row(
                          children: [
                            UpiPinButton(text: "4", onTap: () {}),
                            UpiPinButton(text: "5", onTap: () {}),
                            UpiPinButton(text: "6", onTap: () {}),
                          ],
                        ),
                        Row(
                          children: [
                            UpiPinButton(text: "7", onTap: () {}),
                            UpiPinButton(text: "8", onTap: () {}),
                            UpiPinButton(text: "9", onTap: () {}),
                          ],
                        ),
                        Row(
                          children: [
                            UpiBackButton(onTap: () {}),
                            UpiPinButton(text: "0", onTap: () {}),
                            UpiCheckButton(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: kUpiPinColor,
                                      ),
                                    );
                                  }),
                                );
                                Future.delayed(
                                  const Duration(seconds: 3),
                                  () {
                                    Navigator.of(context).pushReplacement(
                                      CupertinoPageRoute(
                                        builder: (context) => const SuccessScreen(),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
