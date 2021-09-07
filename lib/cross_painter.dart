import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CrossPainter extends CustomPainter {
  final BuildContext context;
  final Paint currentPaint;

  CrossPainter({
    required this.context,
  }) : currentPaint = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.5
          ..strokeCap = StrokeCap.butt;

  @override
  void paint(Canvas canvas, Size size) {
    final screen = MediaQuery.of(context).size;
    canvas.drawLine(Offset(screen.width / 2, 0),
        Offset(screen.width / 2, screen.height), currentPaint);
    canvas.drawLine(
      Offset(
        0,
        screen.height / 2,
      ),
      Offset(screen.width, screen.height / 2),
      currentPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
