import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

class ItemBehaviour {
  ShapeType shape;
  IconData? icon;
  ui.Image? image;

  ItemBehaviour({required this.shape, this.icon, this.image});
}

enum ShapeType {
  FilledCircle,
  StrokeCircle,
  DoubleStrokeCircle,
  TripleStrokeCircle,
  FilledSquare,
  StrokeSquare,
  DoubleStrokeSquare,
  TripleStrokeSquare,
  Icon,
  Image,
}
