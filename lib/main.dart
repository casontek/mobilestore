
import 'package:flutter/material.dart';
import 'package:mobilestore/screens/auth/entry_screen.dart';
import 'package:mobilestore/screens/auth/login_screen.dart';
import 'package:mobilestore/screens/auth/sign_up_screen.dart';
import 'package:mobilestore/theme/material_color.dart';

void main() {
  runApp(const SmartPay());
}

class SmartPay extends StatelessWidget {
  const SmartPay({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: getLightTheme(),
        themeMode: ThemeMode.light,
        routes: {
          '/product': (context) => ProductScreen(),
          '/listing': (context) => ListingScreen(),
          '/register': (context) => const SignUpScreen(),
          '/login': (context) => const LoginScreen(),
        },
        home: const EntryScreen()
    );
  }
}
