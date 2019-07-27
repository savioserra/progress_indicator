import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as Vector;

class ProgressIndicator extends StatelessWidget {
  final double size;
  final double gutter;
  final double strokeWidth;
  final double startAngle;
  final int sessions;
  final double percentage;

  const ProgressIndicator({
    @required this.size,
    this.percentage = 0,
    this.gutter = 0.0,
    this.strokeWidth = 5,
    this.sessions = 5,
    this.startAngle = -90,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: ProgressIndicatorPainter(
        currentPercentage: percentage,
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
    return ((size.width - strokeWidth) / 2);
  }

  double get sessionSize {
    return (2 * Math.pi - (sessions * gutter)) / sessions;
  }

  void drawOuterPath(Canvas canvas, Paint paint, double radius, Offset center) {
    var path = Path();
    var session = sessionSize;

    var start = Vector.radians(startAngle) + gutter / 2;
    for (var i = 0; i < sessions; i++) {
      path.addArc(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
        start,
        session,
      );

      start += sessionSize + gutter;
    }

    canvas.drawPath(path, paint);
  }

  void drawInnerPath(Canvas canvas, Paint paint, double radius,
      double percentage, Offset center) {
    var path = Path();
    var session = sessionSize;

    var sweepAngle = (2 * Math.pi - (sessions * gutter)) * percentage;

    var start = Vector.radians(startAngle) + gutter / 2;
    while (sweepAngle > session) {
      path.addArc(
        Rect.fromCircle(
          center: center,
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
        center: Offset(radius + strokeWidth / 2, radius + strokeWidth / 2),
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

    var center = Offset(radius + strokeWidth / 2, radius + strokeWidth / 2);

    drawOuterPath(canvas, outerPaint, radius, center);
    drawInnerPath(canvas, innerPaint, radius, currentPercentage, center);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
//    var old = oldDelegate as AvatarIndicatorPainter;
//    return old.currentPercentage != currentPercentage;
    return true;
  }
}
