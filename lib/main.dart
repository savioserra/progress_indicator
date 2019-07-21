import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as Vector;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  double gutter = 0.0;
  double percentage = 0;
  double strokeWidth = 1;
  int sessions = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                alignment: Alignment.center,
                child: CustomPaint(
                  painter: AvatarIndicatorPainter(
                    currentPercentage: percentage,
                    gutter: gutter,
                    sessions: sessions,
                    strokeWidth: strokeWidth,
                  ),
                  size: Size(200, 200),
                ),
              ),
              Row(
                children: [
                  Text("Gutter"),
                  Expanded(
                    child: Slider(
                      inactiveColor: Colors.grey[100],
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
                    child: Slider(
                      value: sessions.toDouble(),
                      inactiveColor: Colors.grey[100],
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
                    child: Slider(
                      value: percentage,
                      inactiveColor: Colors.grey[100],
                      onChanged: (v) => setState(() => percentage = v),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Stroke Width"),
                  Expanded(
                    child: Slider(
                      value: strokeWidth,
                      max: 20,
                      inactiveColor: Colors.grey[100],
                      onChanged: (v) => setState(() => strokeWidth = v),
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

class AvatarIndicatorPainter extends CustomPainter {
  final double currentPercentage;
  final int sessions;
  final double gutter;
  final double strokeWidth;

  final double startAngle;

  const AvatarIndicatorPainter({
    @required this.currentPercentage,
    this.sessions,
    this.gutter,
    this.strokeWidth,
    this.startAngle = -90.0,
  });

  double getRadius(Size size) {
    return (size.width / 2) - strokeWidth;
  }

  double get sessionSize {
    return (2 * Math.pi - (sessions * gutter)) / sessions;
  }

  void drawOuterPath(Canvas canvas, Paint paint, double radius) {
    var path = Path();
    var session = sessionSize;

    var start = Vector.radians(startAngle) + gutter / 2;
    for (var i = 0; i < sessions; i++) {
      path.addArc(
        Rect.fromCircle(
          center: Offset(radius + strokeWidth, radius + strokeWidth),
          radius: radius,
        ),
        start,
        session,
      );

      start += sessionSize + gutter;
    }

    canvas.drawPath(path, paint);
  }

  void drawInnerPath(
      Canvas canvas, Paint paint, double radius, double percentage) {
    var path = Path();
    var session = sessionSize;

    var sweepAngle = (2 * Math.pi - (sessions * gutter)) * percentage;

    var start = Vector.radians(startAngle) + gutter / 2;
    while (sweepAngle > session) {
      path.addArc(
        Rect.fromCircle(
          center: Offset(radius + strokeWidth, radius + strokeWidth),
          radius: radius,
        ),
        start,
        session,
      );

      start += session + gutter;
      sweepAngle -= session;
    }

    path.addArc(
      Rect.fromCircle(
        center: Offset(radius + strokeWidth, radius + strokeWidth),
        radius: radius,
      ),
      start,
      sweepAngle,
    );

    canvas.drawPath(path, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    var radius = getRadius(size);

    var outerPaint = Paint()
      ..color = Colors.grey[300]
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    var innerPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    drawOuterPath(canvas, outerPaint, radius);
    drawInnerPath(canvas, innerPaint, radius, currentPercentage);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
//    var old = oldDelegate as AvatarIndicatorPainter;
//    return old.currentPercentage != currentPercentage;
    return true;
  }
}
