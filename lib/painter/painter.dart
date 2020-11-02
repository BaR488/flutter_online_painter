import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_pain_prototype/painter_state/painter_state.dart';
import 'package:flutter_pain_prototype/primitives/primitives.dart';

class CanvasPainter extends CustomPainter {
  PainterState data;

  CanvasPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final pointMode = PointMode.points;
    final pointPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final linePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    for (var primitive in data.primitives) {
      if (primitive is Point) {
        canvas.drawPoints(pointMode, [primitive.toOffset()], pointPaint);
      }

      if (primitive is Line) {
        canvas.drawLine(primitive.start, primitive.end, linePaint);
      }
    }
  }

  @override
  bool shouldRepaint(CanvasPainter old) {
    return old.data != data;
  }
}
