import 'package:flutter/cupertino.dart';

class ItemBehaviour {
  ShapeType shape;
  IconData? icon;

  ItemBehaviour({required this.shape, this.icon});
}

enum ShapeType {
  FilledCircle,
  StrokeCircle,
  DoubleStrokeCircle,
  TripleStrokeCircle,
  FilledTriangle,
  StrokeTriangle,
  DoubleStrokeTriangle,
  TripleStrokeTriangle,
  Icon
}
