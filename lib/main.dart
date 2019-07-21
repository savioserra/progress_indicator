import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:level_indicator/screens/header.dart';
import 'package:level_indicator/screens/indicator.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));

  runApp(PoC());
}

class PoC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (ctx) => IndicatorScreen(),
        "/header": (ctx) => HeaderScreen(),
      },
    );
  }
}
