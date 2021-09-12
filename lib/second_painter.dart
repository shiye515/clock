import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'dart:math' show min;

class SecondPainter extends CustomPainter {
  final int length;
  final Color color;
  final Paint currentPaint;

  SecondPainter({
    required this.length,
    required this.color,
  }) : currentPaint = Paint()
          ..color = color
          ..style = PaintingStyle.fill
          ..strokeWidth = 0.5
          ..strokeCap = StrokeCap.butt;

  @override
  void paint(Canvas canvas, Size size) {
    var cellWidth = size.width / 36;
    var paintWidth = cellWidth * 0.94;
    var progress = (length % 60000) / 60000;
    var height = size.height - cellWidth / 2 - cellWidth * (length ~/ 2160000);
    var offsetTop = height * progress;
    var offsetLeft = cellWidth / 2 + cellWidth * ((length ~/ 60000) % 36);
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(offsetLeft, offsetTop),
        width: paintWidth,
        height: paintWidth,
      ),
      currentPaint,
    );
  }

  @override
  bool shouldRepaint(SecondPainter oldDelegate) => oldDelegate.length != length;
}
