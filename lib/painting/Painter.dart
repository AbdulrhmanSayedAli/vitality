import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:vitality/shapesManagement/Shape.dart';

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
    return true; //oldDelegate.shapes != shapes || oldDelegate.background != background;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [shapes, background];

  @override
  // TODO: implement stringify
  bool? get stringify => true;
}
