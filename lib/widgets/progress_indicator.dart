import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as Vector;

class ProgressIndicator extends AnimatedWidget {
  final double size;
  final double gutter;
  final double strokeWidth;
  final double startAngle;
  final int sessions;

  final Animation<double> animation;

  const ProgressIndicator({
    @required this.size,
    this.gutter = 0.0,
    this.strokeWidth = 5,
    this.sessions = 5,
    this.startAngle = -90,
    this.animation,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: ProgressIndicatorPainter(
        currentPercentage: animation.value,
        sessions: sessions,
        gutter: gutter,
        strokeWidth: strokeWidth,
        startAngle: startAngle,
      ),
    );
  }
}

class ProgressIndicatorPainter extends CustomPainter {
  final double currentPercentage;
  final int sessions;
  final double gutter;
  final double strokeWidth;

  final double startAngle;

  const ProgressIndicatorPainter({
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
