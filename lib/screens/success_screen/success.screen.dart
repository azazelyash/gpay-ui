import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpay_ui/constants.dart';
import 'package:gpay_ui/screens/amount_screen/amount.screen.dart';
import 'package:gpay_ui/screens/amount_screen/provider/amount.service.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> with TickerProviderStateMixin {
  late final AnimationController _successAnimtionController;
  late final AnimationController _buttonAnimtionController;

  @override
  void initState() {
    super.initState();

    _successAnimtionController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _buttonAnimtionController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _successAnimtionController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _buttonAnimtionController.forward();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _successAnimtionController.dispose();
  }

  void playAnimation() async {
    _successAnimtionController.forward().then(
          (_) => {
            setState(() {
              play = true;
            }),
          },
        );
  }

  bool play = false;

  @override
  Widget build(BuildContext context) {
    playAnimation();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            AnimatedPositioned(
              curve: Curves.easeInOut,
              left: 0,
              right: 0,
              top: 0,
              bottom: (play) ? 200 : 0,
              duration: const Duration(milliseconds: 350),
              child: Lottie.asset(
                'assets/animation/SuccessAnimation.json',
                controller: _successAnimtionController,
              ),
            ),
            Positioned(
              top: 130,
              left: 0,
              right: 0,
              bottom: 0,
              child: Center(
                child: FadeTransition(
                  opacity: _buttonAnimtionController,
                  child: SizedBox(
                    height: 80,
                    child: Column(
                      children: [
                        Consumer<AmountService>(
                          builder: (context, value, child) {
                            return Text(
                              "₹ ${value.amount}",
                              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            );
                          },
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Paid to Yash Vishwakarma",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "(sample@upiid)",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 280,
              child: Center(
                child: FadeTransition(
                  opacity: _buttonAnimtionController,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: 100,
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: kPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          CupertinoPageRoute(
                            builder: (context) => const AmountScreen(),
                          ),
                        );
                      },
                      child: const Text("Done"),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
