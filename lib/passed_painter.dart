import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'dart:math' show min;

class PassedPainter extends CustomPainter {
  final int length;
  final Color color;
  final Paint currentPaint;

  PassedPainter({
    required int length,
    required this.color,
  })  : currentPaint = Paint()
          ..color = color
          ..style = PaintingStyle.fill
          ..strokeWidth = 0.5
          ..strokeCap = StrokeCap.butt,
        length = length ~/ 60000;

  @override
  void paint(Canvas canvas, Size size) {
    int rowCount = (size.height > size.width) ? 36 : 60;
    var cellWidth = size.width / rowCount;
    var paintWidth = cellWidth * 0.94;
    // print('passed $length');
    for (var i = 0; i < length; i++) {
      var offsetTop = size.height - cellWidth / 2 - cellWidth * (i ~/ rowCount);
      var offsetLeft = cellWidth * (i % rowCount) + cellWidth / 2;

      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(offsetLeft, offsetTop),
          width: paintWidth,
          height: paintWidth,
        ),
        currentPaint,
      );
    }
  }

  @override
  bool shouldRepaint(PassedPainter oldDelegate) => oldDelegate.length != length;
}
