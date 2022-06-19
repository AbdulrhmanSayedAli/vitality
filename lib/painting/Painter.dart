import 'package:flutter/material.dart';
import 'package:vitality/shapesManagement/Shape.dart';

class VitalityPainter extends CustomPainter {
  List<Shape> shapes;
  Color? background;

  VitalityPainter(this.shapes, this.background);

  @override
  void paint(Canvas canvas, Size size) {
    if (background != null) canvas.drawColor(background!, BlendMode.srcOver);
    shapes.forEach((element) {
      element.draw(canvas, size);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
