
import 'package:flutter/material.dart';
import 'package:mobilestore/screens/auth/entry_screen.dart';
import 'package:mobilestore/screens/auth/login_screen.dart';
import 'package:mobilestore/screens/auth/sign_up_screen.dart';
import 'package:mobilestore/screens/others/listing_screen.dart';
import 'package:mobilestore/screens/others/product_screen.dart';
import 'package:mobilestore/screens/others/profile_screen.dart';
import 'package:mobilestore/theme/material_color.dart';

void main() {
  runApp(const MobileStore());
}

class MobileStore extends StatelessWidget {
  const MobileStore({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: getLightTheme(),
        themeMode: ThemeMode.light,
        routes: {
          '/product': (context) => const ProductScreen(),
          '/listing': (context) => const ListingScreen(),
          '/register': (context) => const SignUpScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/login': (context) => const LoginScreen(),
        },
        home: const EntryScreen()
    );
  }
}
