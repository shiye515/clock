import 'package:flutter/material.dart';
import 'dart:math' show pi, max;

import 'package:flutter/rendering.dart';

class FlowPainter extends CustomPainter {
  final BuildContext context;

  /// 动画进度
  final ValueNotifier<double> animationProgress;

  /// 变化的颜色列表
  final List<Color> colors;

  FlowPainter({
    required this.context,
    required this.animationProgress,
    required this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final screen = MediaQuery.of(context).size;
    var page = animationProgress.value.floor();
    var nextPage = animationProgress.value.ceil();
    final progress = animationProgress.value % 1;
    final maxBorder = max(screen.width, screen.height) * 2;
    Rect rect = Rect.fromLTWH((screen.width - maxBorder) / 2,
        (screen.height - maxBorder) / 2, maxBorder, maxBorder);

    Paint currentPaint = Paint()..color = colors[page % colors.length];
    Paint nextPaint = Paint()..color = colors[nextPage % colors.length];

    /// 绘制背景
    // canvas.drawRect(backgroundRect, backgroundPaint);
    canvas.drawArc(rect, 0, pi * 2 * (1 - progress), true, currentPaint);
    canvas.drawArc(rect, 0, -pi * 2 * progress, true, nextPaint);
    // canvas.drawRRect(
    //   RRect.fromRectAndRadius(buttonRect, Radius.circular(screen.height)),
    //   buttonPaint,
    // );

    // 上下的动画
    // canvas.drawRect(
    //     Rect.fromLTWH(0, 0, screen.width, screen.height * (1 - progress)),
    //     currentPaint);
    // canvas.drawRect(
    //     Rect.fromLTWH(
    //         0, screen.height * (1 - progress), screen.width, screen.height),
    //     nextPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
