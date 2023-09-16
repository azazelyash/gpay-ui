import 'package:flutter/material.dart';
import 'package:gpay_ui/screens/amount_screen/provider/dropdown.service.dart';
import 'package:gpay_ui/screens/splash_screen/splash.screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DropdownService>(
          create: (_) => DropdownService(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
