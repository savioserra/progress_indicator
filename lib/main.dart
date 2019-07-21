import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:level_indicator/screens/indicator.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
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
      },
    );
  }
}
