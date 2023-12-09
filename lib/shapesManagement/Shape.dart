import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:vitality/models/ItemBehaviour.dart';
import 'package:vitality/models/WhenOutOfScreenMode.dart';

/// Represents the physical manifestation of a shape, such as a moving circle, icon, image, etc.
///
/// When creating an instance of this class, provide the following parameters:
///
/// - [pos] The initial position of the shape.
/// - [dx] The speed of the shape on the X-axis.
/// - [dy] The speed of the shape on the Y-axis.
/// - [size] The size of the shape.
/// - [color] The color of the shape.
/// - [whenOutOfScreenMode] The behavior of the shape at the screen edge (see [WhenOutOfScreenMode] for more details).
/// - [behaviour] The behavior of the shape at the screen edge (see [ItemBehaviour] for more details).
/// ignore: must_be_immutable
class Shape implements Equatable {
  Offset pos;
  double dx;
  double dy;
  double size;
  Color color;
  ItemBehaviour behaviour;
  WhenOutOfScreenMode whenOutOfScreenMode;

  Shape(
      {required this.pos,
      required this.dx,
      required this.dy,
      required this.size,
      required this.color,
      required this.whenOutOfScreenMode,
      required this.behaviour});

  /// Draws multiple circles with centers positioned at [pos].
  ///
  /// Parameters:
  /// - [canvas] The Canvas object from custom paint used for drawing the circles.
  /// - [sizes] List of radiuses for the circles to be drawn.
  void drawCircles(Canvas canvas, List<double> sizes) {
    for (double rad in sizes) canvas.drawCircle(pos, rad, getPaint());
  }

  /// Draws multiple squares with centers positioned at [pos].
  ///
  /// Parameters:
  /// - [canvas] The Canvas object from custom paint used for drawing the squares.
  /// - [sizes] List of sizes for the squares to be drawn.
  void drawSquares(Canvas canvas, List<double> sizes) {
    for (double d in sizes)
      canvas.drawRect(
          Rect.fromPoints(
              Offset(pos.dx - d, pos.dy - d), Offset(pos.dx + d, pos.dy + d)),
          getPaint());
  }

  void drawIcon(Canvas canvas) {
    if (behaviour.icon == null) return;
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
  }

  void drawImage(Canvas canvas) {
    if (behaviour.image == null) return;
    double w = behaviour.image!.width.toDouble();
    double h = behaviour.image!.height.toDouble();
    double scaledW = this.size;
    double scaledH = (scaledW * h) / w;

    canvas.drawImageRect(
        behaviour.image!,
        Rect.fromLTWH(0, 0, w, h),
        Rect.fromPoints(Offset(pos.dx - scaledW / 2, pos.dy - scaledH / 2),
            Offset(pos.dx + scaledW / 2, pos.dy + scaledH / 2)),
        getPaint());
  }

  void draw(Canvas canvas) {
    switch (behaviour.shape) {
      case ShapeType.FilledCircle:
        drawCircles(canvas, [this.size / 2]);
        break;
      case ShapeType.StrokeCircle:
        drawCircles(canvas, [this.size / 2]);
        break;
      case ShapeType.DoubleStrokeCircle:
        drawCircles(canvas, [this.size / 2, this.size / 4]);
        break;
      case ShapeType.TripleStrokeCircle:
        drawCircles(canvas, [this.size / 2, this.size / 3, this.size / 6]);
        break;
      case ShapeType.FilledSquare:
        drawSquares(canvas, [this.size / 2]);
        break;
      case ShapeType.StrokeSquare:
        drawSquares(canvas, [this.size / 2]);
        break;
      case ShapeType.DoubleStrokeSquare:
        drawSquares(canvas, [this.size / 2, this.size / 4]);
        break;
      case ShapeType.TripleStrokeSquare:
        drawSquares(canvas, [this.size / 2, this.size / 3, this.size / 6]);
        break;
      case ShapeType.Icon:
        drawIcon(canvas);
        break;
      case ShapeType.Image:
        drawImage(canvas);
        break;
    }
  }

  Paint getPaint() {
    Paint paint = Paint();
    paint.color = color;
    if (behaviour.shape == ShapeType.FilledCircle ||
        behaviour.shape == ShapeType.FilledSquare)
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

  void delta(double width, double height) {
    if (whenOutOfScreenMode == WhenOutOfScreenMode.none)
      deltaNone(width, height);
    else if (whenOutOfScreenMode == WhenOutOfScreenMode.Teleport)
      deltaTeleport(width, height);
    else
      deltaReflect(width, height);
  }

  @override
  List<Object?> get props =>
      [pos, dx, dy, size, color, behaviour, whenOutOfScreenMode];

  @override
  bool? get stringify => true;
}
