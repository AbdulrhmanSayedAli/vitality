import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vitality/models/ItemBehaviour.dart';

import 'Shape.dart';

class ShapesGenerator {
  double maxWidth;
  double maxHeight;
  double maxSize;
  double minSize;
  double maxOpacity;
  double minOpacity;
  double maxSpeed;
  double minSpeed;
  bool enableXMovements;
  bool enableYMovements;
  late List<ItemBehaviour> behaviours;
  late List<Color> colors;

  ShapesGenerator.Randomly(
      {required this.maxWidth,
      required this.maxHeight,
      required this.enableXMovements,
      required this.enableYMovements,
      required this.maxSize,
      required this.minSize,
      required this.maxOpacity,
      required this.minOpacity,
      required List<ItemBehaviour> behaviours,
      required List<Color> colors,
      required this.maxSpeed,
      required this.minSpeed}) {
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

    colors.shuffle();
    behaviours.shuffle();
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
              pos: Offset(getDouble(0, maxWidth), getDouble(0, maxHeight)),
              dx: enableXMovements ? randomSpeed() : 0,
              dy: enableYMovements ? randomSpeed() : 0,
              size: getDouble(minSize, maxSize),
              color: colors[getDouble(0, colors.length - 1).toInt()]
                  .withOpacity(getDouble(minOpacity, maxOpacity)),
              behaviour:
                  behaviours[getDouble(0, behaviours.length - 1).toInt()],
            ));
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
        ),
      );
      x += size + space;
    }
    return res;
  }
}
