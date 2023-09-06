import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:vitality/models/ItemBehaviour.dart';

class Shape implements Equatable {
  late Offset pos;
  late double dx;
  late double dy;
  late double size;
  late Color color;
  late ItemBehaviour behaviour;

  Shape(
      {required this.pos,
      required this.dx,
      required this.dy,
      required this.size,
      required this.color,
      required this.behaviour});

  void draw(Canvas canvas, Size size) {
    if (behaviour.shape == ShapeType.FilledCircle)
      canvas.drawCircle(pos, this.size / 2, getPaint());
    else if (behaviour.shape == ShapeType.TripleStrokeCircle) {
      canvas.drawCircle(pos, this.size / 2, getPaint());
      canvas.drawCircle(pos, this.size / 6, getPaint());
      canvas.drawCircle(pos, this.size / 3, getPaint());
    } else if (behaviour.shape == ShapeType.DoubleStrokeCircle) {
      canvas.drawCircle(pos, this.size / 2, getPaint());
      canvas.drawCircle(pos, this.size / 4, getPaint());
    } else if (behaviour.shape == ShapeType.FilledTriangle) {
      canvas.drawRect(
          Rect.fromPoints(
              Offset(pos.dx - this.size / 2, pos.dy - this.size / 2),
              Offset(pos.dx + this.size / 2, pos.dy + this.size / 2)),
          getPaint());
    } else if (behaviour.shape == ShapeType.StrokeTriangle) {
      canvas.drawRect(
          Rect.fromPoints(
              Offset(pos.dx - this.size / 2, pos.dy - this.size / 2),
              Offset(pos.dx + this.size / 2, pos.dy + this.size / 2)),
          getPaint());
    } else if (behaviour.shape == ShapeType.DoubleStrokeTriangle) {
      canvas.drawRect(
          Rect.fromPoints(
              Offset(pos.dx - this.size / 2, pos.dy - this.size / 2),
              Offset(pos.dx + this.size / 2, pos.dy + this.size / 2)),
          getPaint());
      canvas.drawRect(
          Rect.fromPoints(
              Offset(pos.dx - this.size / 4, pos.dy - this.size / 4),
              Offset(pos.dx + this.size / 4, pos.dy + this.size / 4)),
          getPaint());
    } else if (behaviour.shape == ShapeType.TripleStrokeTriangle) {
      canvas.drawRect(
          Rect.fromPoints(
              Offset(pos.dx - this.size / 2, pos.dy - this.size / 2),
              Offset(pos.dx + this.size / 2, pos.dy + this.size / 2)),
          getPaint());

      canvas.drawRect(
          Rect.fromPoints(
              Offset(pos.dx - this.size / 3, pos.dy - this.size / 3),
              Offset(pos.dx + this.size / 3, pos.dy + this.size / 3)),
          getPaint());

      canvas.drawRect(
          Rect.fromPoints(
              Offset(pos.dx - this.size / 6, pos.dy - this.size / 6),
              Offset(pos.dx + this.size / 6, pos.dy + this.size / 6)),
          getPaint());
    } else if (behaviour.shape == ShapeType.Icon && behaviour.icon != null) {
      TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
      textPainter.text = TextSpan(
        text: String.fromCharCode(behaviour.icon!.codePoint),
        style: TextStyle(
          color: color,
          fontSize: this.size,
          fontFamily: behaviour.icon!.fontFamily,
          package: behaviour.icon!.fontPackage,
        ),
      );
      textPainter.layout();
      textPainter.paint(
          canvas, Offset(pos.dx - this.size / 2, pos.dy - this.size / 2));

//      var builder = ParagraphBuilder(ParagraphStyle(
//        fontFamily: behaviour.icon!.fontFamily,
//      ))
//        ..addText(String.fromCharCode(behaviour.icon!.codePoint));
//      var para = builder.build();
//      para.layout(ParagraphConstraints(width: this.size));
//      canvas.drawParagraph(para, Offset(pos.dx - this.size / 2, pos.dy - this.size / 2));
    } else if (behaviour.shape == ShapeType.Image && behaviour.image != null) {
      canvas.drawImage(behaviour.image!, pos, getPaint());
    }
  }

  Paint getPaint() {
    Paint paint = Paint();
    paint.color = color;
    if (behaviour.shape == ShapeType.FilledCircle ||
        behaviour.shape == ShapeType.FilledTriangle)
      paint.style = PaintingStyle.fill;
    else
      paint.style = PaintingStyle.stroke;

    return paint;
  }

  void deltaNone(double width, double height) {
    double x = pos.dx + dx;
    double y = pos.dy + dy;
    pos = Offset(x, y);
  }

  void deltaTeleport(double width, double height) {
    double x = pos.dx + dx;
    double y = pos.dy + dy;
    pos = Offset(
        x < -size / 2
            ? width + size / 2
            : x > width + size / 2
                ? -size / 2
                : x,
        y < -size / 2
            ? height + size / 2
            : y > height + size / 2
                ? -size / 2
                : y);
  }

  void deltaReflect(double width, double height) {
    double x = pos.dx + dx;
    double y = pos.dy + dy;
    if (x < size / 2) {
      dx *= -1;
      x = size / 2;
    } else if (x > width - size / 2) {
      dx *= -1;
      x = width - size / 2;
    }
    if (y < size / 2) {
      dy *= -1;
      y = size / 2;
    } else if (y > height - size / 2) {
      dy *= -1;
      y = height - size / 2;
    }
    pos = Offset(x, y);
  }

  @override
  List<Object?> get props => [pos, dx, dy, size, color, behaviour];

  @override
  bool? get stringify => true;
}
