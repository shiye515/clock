import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HandPainter extends CustomPainter {
  final BuildContext context;
  final Color color;
  final int alpha;
  final double rectWidth;
  final double strokeWidth;
  final double progress;

  final Paint currentPaint;

  HandPainter({
    required this.context,
    required this.color,
    this.alpha = 200,
    required this.rectWidth,
    required this.strokeWidth,
    required this.progress,
  }) : currentPaint = Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth * 0.94
          ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    final screen = MediaQuery.of(context).size;
    Rect rect = Rect.fromLTWH((screen.width - rectWidth) / 2,
        (screen.height - rectWidth) / 2, rectWidth, rectWidth);
    canvas.drawArc(rect, -pi / 2, pi * 2 * progress, false, currentPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
