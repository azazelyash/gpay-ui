import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gpay_ui/constants.dart';
import 'package:gpay_ui/screens/success_screen/success.screen.dart';
import 'package:gpay_ui/screens/upi_pin_screen/components/custom.clipper.dart';
import 'package:gpay_ui/screens/upi_pin_screen/components/upi.number.button.dart';
import 'package:gpay_ui/screens/upi_pin_screen/components/upi.special.button.dart';
import 'package:gpay_ui/screens/upi_pin_screen/models/tax.model.dart';
import 'package:gpay_ui/screens/upi_pin_screen/provider/dropdown.service.dart';
import 'package:gpay_ui/screens/upi_pin_screen/provider/upi.pin.provider.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class UpiPinScreen extends StatefulWidget {
  const UpiPinScreen({super.key});

  @override
  State<UpiPinScreen> createState() => _UpiPinScreenState();
}

class _UpiPinScreenState extends State<UpiPinScreen> with TickerProviderStateMixin {
  late AnimationController _counterClockwiseRotationController;
  late Animation<double> _counterClockwiseRotationAnimation;

  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  void checkButton(UpiPinService value) async {
    if (!value.isUpiPinValid()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(milliseconds: 1500),
          content: Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.white,
              ),
              SizedBox(width: 10),
              Text("Invalid UPI PIN"),
            ],
          ),
        ),
      );
      return;
    }
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: ((context) {
        _counterClockwiseRotationController
          ..reset()
          ..forward();

        return AnimatedBuilder(
          animation: _counterClockwiseRotationController,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateZ(
                  _counterClockwiseRotationAnimation.value,
                ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _flipController,
                    builder: (context, child) {
                      return Transform(
                        alignment: Alignment.centerRight,
                        transform: Matrix4.identity()
                          ..rotateY(
                            _flipAnimation.value,
                          ),
                        child: ClipPath(
                          clipper: const HalfCircleClipper(side: CircleSide.left),
                          child: Container(
                            color: kPrimaryColor,
                            width: 50,
                            height: 50,
                          ),
                        ),
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: _flipAnimation,
                    builder: (context, child) {
                      return Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.identity()
                          ..rotateY(
                            _flipAnimation.value,
                          ),
                        child: ClipPath(
                          clipper: const HalfCircleClipper(side: CircleSide.right),
                          child: Container(
                            color: kUpiPinColor,
                            width: 50,
                            height: 50,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
    await Future.delayed(
      const Duration(seconds: 3),
    );
    if (context.mounted) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(
          builder: (context) => const SuccessScreen(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    _counterClockwiseRotationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );

    _counterClockwiseRotationAnimation = Tween<double>(
      begin: 0,
      end: -(pi / 2.0),
    ).animate(
      CurvedAnimation(
        parent: _counterClockwiseRotationController,
        curve: Curves.bounceOut,
      ),
    );

    // flip animation

    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );

    _flipAnimation = Tween<double>(
      begin: 0,
      end: pi,
    ).animate(
      CurvedAnimation(
        parent: _flipController,
        curve: Curves.bounceOut,
      ),
    );

    // status listeners

    _counterClockwiseRotationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _flipAnimation = Tween<double>(
          begin: _flipAnimation.value,
          end: _flipAnimation.value + pi,
        ).animate(
          CurvedAnimation(
            parent: _flipController,
            curve: Curves.bounceOut,
          ),
        );

        // reset the flip controller and start the animation

        _flipController
          ..reset()
          ..forward();
      }
    });

    _flipController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _counterClockwiseRotationAnimation = Tween<double>(
            begin: _counterClockwiseRotationAnimation.value,
            end: _counterClockwiseRotationAnimation.value + -(pi / 2.0),
          ).animate(
            CurvedAnimation(
              parent: _counterClockwiseRotationController,
              curve: Curves.bounceOut,
            ),
          );
          _counterClockwiseRotationController
            ..reset()
            ..forward();
        }
      },
    );
  }

  @override
  void dispose() {
    _counterClockwiseRotationController.dispose();
    _flipController.dispose();
    super.dispose();
  }

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
                                  onPressed: () {
                                    value.toggleObscure();
                                  },
                                  splashRadius: 25,
                                  icon: Icon(
                                    (value.isObscure) ? Icons.visibility_off : Icons.visibility,
                                    color: kUpiPinColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Pinput(
                                defaultPinTheme: PinTheme(
                                  margin: const EdgeInsets.symmetric(horizontal: 2),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  constraints: const BoxConstraints(
                                    minHeight: 50,
                                    minWidth: 50,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                  ),
                                  textStyle: const TextStyle(
                                    color: kUpiPinColor,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                obscureText: value.isObscure,
                                controller: value.upiPinController,
                                keyboardType: TextInputType.none,
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
                                value.addNumber("1");
                              },
                            ),
                            UpiPinButton(
                              text: "2",
                              onTap: () {
                                value.addNumber("2");
                              },
                            ),
                            UpiPinButton(
                              text: "3",
                              onTap: () {
                                value.addNumber("3");
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            UpiPinButton(
                              text: "4",
                              onTap: () {
                                value.addNumber("4");
                              },
                            ),
                            UpiPinButton(
                              text: "5",
                              onTap: () {
                                value.addNumber("5");
                              },
                            ),
                            UpiPinButton(
                              text: "6",
                              onTap: () {
                                value.addNumber("6");
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            UpiPinButton(
                              text: "7",
                              onTap: () {
                                value.addNumber("7");
                              },
                            ),
                            UpiPinButton(
                              text: "8",
                              onTap: () {
                                value.addNumber("8");
                              },
                            ),
                            UpiPinButton(
                              text: "9",
                              onTap: () {
                                value.addNumber("9");
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            UpiBackButton(
                              onTap: () {
                                value.removeNumber();
                              },
                            ),
                            UpiPinButton(
                              text: "0",
                              onTap: () {
                                value.addNumber("0");
                              },
                            ),
                            UpiCheckButton(
                              onTap: () {
                                checkButton(value);
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
