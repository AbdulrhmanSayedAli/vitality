import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:vitality/shapesManagement/Shape.dart';

// ignore: must_be_immutable
class VitalityPainter extends CustomPainter implements Equatable {
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
  bool shouldRepaint(VitalityPainter oldDelegate) {
    return true;
  }

  @override
  List<Object?> get props => [shapes, background];

  @override
  bool? get stringify => true;
}
