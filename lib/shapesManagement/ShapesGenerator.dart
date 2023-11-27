import 'dart:math';
import 'dart:ui';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:vitality/models/ItemBehaviour.dart';
import 'package:vitality/models/WhenOutOfScreenMode.dart';
import 'package:vitality/vitality.dart';
import 'Shape.dart';

// ignore: must_be_immutable
class ShapesGenerator implements Equatable {
  double maxWidth;
  double maxHeight;
  double minWidth;
  double minHeight;
  double maxSize;
  double minSize;
  double maxOpacity;
  double minOpacity;
  double maxSpeed;
  double minSpeed;
  bool enableXMovements;
  bool enableYMovements;
  List<ItemBehaviour> behaviours = [];
  List<Color> colors = [];
  WhenOutOfScreenMode whenOutOfScreenMode;

  ShapesGenerator.randomly({
    required this.maxWidth,
    required this.maxHeight,
    this.minWidth = 0,
    this.minHeight = 0,
    this.enableXMovements = DefaultenableXMovements,
    this.enableYMovements = DefaultenableYMovements,
    this.maxSize = DefaultmaxSize,
    this.minSize = DefaultminSize,
    this.maxOpacity = DefaultmaxOpacity,
    this.minOpacity = DefaultminOpacity,
    required List<ItemBehaviour> behaviours,
    required List<Color> colors,
    this.maxSpeed = DefaultmaxSpeed,
    this.minSpeed = DefaultminSpeed,
    this.whenOutOfScreenMode = DefaultwhenOutOfScreenMode,
  }) {
    this.behaviours = [];
    this.colors = [];
    for (ItemBehaviour b in behaviours) {
      this.behaviours.add(b);
      this.behaviours.add(b);
    }
    for (Color c in colors) {
      this.colors.add(c);
      this.colors.add(c);
    }

    this.colors.shuffle();
    this.behaviours.shuffle();
  }

  Random rm = Random();

  double getDouble(double min, double max) =>
      rm.nextDouble() * (max - min) + min;

  double randomSpeed() {
    double speed = getDouble(minSpeed, maxSpeed);
    double direction = rm.nextInt(2) == 0 ? -1 : 1;
    return speed * direction;
  }

  List<Shape> getShapes(int count) {
    return List.generate(
        count,
        (index) => Shape(
            pos: Offset(
                getDouble(minWidth, maxWidth), getDouble(minHeight, maxHeight)),
            dx: enableXMovements ? randomSpeed() : 0,
            dy: enableYMovements ? randomSpeed() : 0,
            size: getDouble(minSize, maxSize),
            color: colors[getDouble(0, colors.length - 1).toInt()]
                .withOpacity(getDouble(minOpacity, maxOpacity)),
            behaviour: behaviours[getDouble(0, behaviours.length - 1).toInt()],
            whenOutOfScreenMode: whenOutOfScreenMode));
  }

  List<Shape> getLinesShapes(int lines) {
    List<Shape> res = [];
    double size = maxHeight / (2 * lines);

    double speed = randomSpeed();
    double space = ((maxWidth % size) + size) / ((maxWidth / size) - 1);
    double x = 0;
    ItemBehaviour behaviour =
        behaviours[getDouble(0, behaviours.length - 1).toInt()];

    Color color = colors[getDouble(0, colors.length - 1).toInt()]
        .withOpacity(getDouble(minOpacity, maxOpacity));

    while (x < maxWidth) {
      res.add(
        Shape(
            pos: Offset(x, size / 2),
            dx: speed,
            dy: 0,
            size: size,
            color: color,
            behaviour: behaviour,
            whenOutOfScreenMode: whenOutOfScreenMode),
      );
      x += size + space;
    }
    return res;
  }

  @override
  List<Object?> get props => [
        minWidth,
        minHeight,
        maxWidth,
        maxHeight,
        maxSize,
        minSize,
        maxOpacity,
        minOpacity,
        maxSpeed,
        minSpeed,
        enableXMovements,
        enableYMovements,
        behaviours,
        colors
      ];

  @override
  bool? get stringify => true;
}
