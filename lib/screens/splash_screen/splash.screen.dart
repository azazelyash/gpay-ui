import 'package:flutter/material.dart';
import 'package:gpay_ui/screens/amount_screen/amount.screen.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void playAnimation() async {
    await _controller.forward();
    if (context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AmountScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    playAnimation();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          'assets/animation/google_splash.json',
          controller: _controller,
        ),
      ),
    );
  }
}
