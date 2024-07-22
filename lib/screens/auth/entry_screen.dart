
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EntryScreen extends StatefulWidget {

  const EntryScreen({super.key});

  @override
  State<StatefulWidget> createState() => _EntryScreen();

}

class _EntryScreen extends State<EntryScreen> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).colorScheme.surface,
            statusBarIconBrightness: Brightness.dark
        ));
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(
            child: Image.asset(
                'assets/images/smartpay_logo.png',
                fit: BoxFit.contain,
                height: 72,
                width: 72
            )
        )
    );
  }

}