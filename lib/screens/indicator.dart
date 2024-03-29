import 'dart:math' as Math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:level_indicator/widgets/drawer.dart';
import 'package:level_indicator/widgets/progress_indicator.dart' as Indicator;

class IndicatorScreen extends StatefulWidget {
  IndicatorScreen({Key key}) : super(key: key);

  @override
  IndicatorScreenState createState() => IndicatorScreenState();
}

class IndicatorScreenState extends State<IndicatorScreen>
    with TickerProviderStateMixin {
  double gutter = 0.0;
  double strokeWidth = 1;
  double percentage = 0;
  double startAngle = -90;
  int sessions = 1;

  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      upperBound: 1.0,
      lowerBound: 0.0,
    );

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: AppDrawer(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                alignment: Alignment.center,
                child: RepaintBoundary(
                  child: AnimatedBuilder(
                    animation: animationController,
                    builder: (ctx, child) => Indicator.ProgressIndicator(
                      size: 200,
                      gutter: gutter,
                      sessions: sessions,
                      strokeWidth: strokeWidth,
                      percentage: animationController.value,
                      startAngle: startAngle,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Text("Gutter"),
                  Expanded(
                    child: CupertinoSlider(
                      activeColor: Colors.black54,
                      value: gutter,
                      min: 0,
                      max: (2 * Math.pi) / sessions,
                      onChanged: (v) => setState(() => gutter = v),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Sessions"),
                  Expanded(
                    child: CupertinoSlider(
                      value: sessions.toDouble(),
                      activeColor: Colors.black54,
                      min: 1,
                      max: 8,
                      divisions: 7,
                      onChanged: (v) => setState(() => sessions = v.toInt()),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Percentage"),
                  Expanded(
                    child: CupertinoSlider(
                      value: percentage,
                      activeColor: Colors.black54,
                      divisions: 10,
                      onChanged: (v) {
                        setState(() => percentage = v);
                        animationController.animateTo(
                          v,
                          curve: const ElasticOutCurve(0.9),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Stroke Width"),
                  Expanded(
                    child: CupertinoSlider(
                      value: strokeWidth,
                      max: 20,
                      activeColor: Colors.black54,
                      onChanged: (v) => setState(() => strokeWidth = v),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Angle"),
                  Expanded(
                    child: CupertinoSlider(
                      value: startAngle,
                      max: 180,
                      min: -180,
                      activeColor: Colors.black54,
                      onChanged: (v) => setState(() => startAngle = v),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
