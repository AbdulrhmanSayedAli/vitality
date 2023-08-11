library vitality;

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'models/ItemBehaviour.dart';
import 'models/WhenOutOfScreenMode.dart';
import 'models/vitalityMode.dart';
import 'painting/Painter.dart';
import 'shapesManagement/Shape.dart';
import 'shapesManagement/ShapesGenerator.dart';

class Vitality extends StatefulWidget {
  late int itemsCount;
  late double maxOpacity;
  late double minOpacity;
  late double maxSize;
  late double minSize;
  late Color? background;
  late double maxSpeed;
  late double minSpeed;
  late bool enableXMovements;
  late bool enableYMovements;
  late WhenOutOfScreenMode whenOutOfScreenMode;
  List<ItemBehaviour> randomItemsBehaviours;
  List<Color> randomItemsColors;
  late VitalityMode mode;
  late int lines;

  Vitality.randomly(
      {this.itemsCount = 60,
      this.maxSize = 50,
      this.minSize = 5,
      this.enableXMovements = true,
      this.enableYMovements = true,
      this.maxOpacity = 0.8,
      this.minOpacity = 0.1,
      this.maxSpeed = 1,
      this.minSpeed = 0,
      this.whenOutOfScreenMode = WhenOutOfScreenMode.none,
      required this.randomItemsBehaviours,
      required this.randomItemsColors,
      Key? key,
      this.background})
      : super(key: key) {
    mode = VitalityMode.Randomly;
    lines = 0;
  }

  Vitality.lines(
      {Key? key,
      this.maxOpacity = 0.8,
      this.minOpacity = 0.1,
      this.maxSpeed = 1,
      this.minSpeed = 0,
      this.lines = 5,
      required this.randomItemsBehaviours,
      required this.randomItemsColors,
      this.background})
      : super(key: key) {
    mode = VitalityMode.Lines;
    whenOutOfScreenMode = WhenOutOfScreenMode.Teleport;
    minSize = maxSize = 0;
    enableXMovements = true;
    enableYMovements = false;
    itemsCount = 0;
  }

  @override
  _VitalityState createState() => _VitalityState(
        maxSpeed: maxSpeed,
        minSpeed: minSpeed,
        count: itemsCount,
        enableXMovements: enableXMovements,
        enableYMovements: enableYMovements,
        maxSize: maxSize,
        randomItemsBehaviours: randomItemsBehaviours,
        whenOutOfScreenMode: whenOutOfScreenMode,
        minSize: minSize,
        mode: mode,
        lines: lines,
        randomItemsColors: randomItemsColors,
        maxOpacity: min(maxOpacity, 1),
        minOpacity: max(minOpacity, 0),
      );
}

class _VitalityState extends State<Vitality> {
  double maxSize;
  double minSize;
  double maxOpacity;
  double minOpacity;
  int count;
  int lines;
  double maxSpeed;
  double minSpeed;
  WhenOutOfScreenMode whenOutOfScreenMode;
  List<ItemBehaviour> randomItemsBehaviours;
  List<Color> randomItemsColors;
  late List<Shape> shapes;
  bool enableXMovements;
  bool enableYMovements;
  VitalityMode mode;
  late ShapesGenerator generator;
  late List<List<Shape>> linesShapes;
  bool finishedInitilization = false;
  late Timer timer;

  _VitalityState({
    required this.minSize,
    required this.whenOutOfScreenMode,
    required this.enableYMovements,
    required this.enableXMovements,
    required this.count,
    required this.lines,
    required this.randomItemsBehaviours,
    required this.randomItemsColors,
    required this.maxSize,
    required this.mode,
    required this.maxOpacity,
    required this.minOpacity,
    required this.minSpeed,
    required this.maxSpeed,
  });

  void initShapes(double width, double height) {
    generator = ShapesGenerator.randomly(
      maxWidth: width,
      maxHeight: height,
      maxSize: maxSize,
      minSize: minSize,
      maxOpacity: maxOpacity,
      minOpacity: minOpacity,
      behaviours: randomItemsBehaviours,
      minSpeed: minSpeed,
      colors: randomItemsColors,
      enableXMovements: enableXMovements,
      enableYMovements: enableYMovements,
      maxSpeed: maxSpeed,
    );

    shapes = generator.getShapes(count);

    linesShapes =
        List.generate(lines, (index) => generator.getLinesShapes(lines));
  }

  void initTimer(double width, double height) {
    timer = Timer.periodic(Duration(milliseconds: 1000 ~/ 60), (t) {
      setState(() {
        shapes.forEach((element) {
          if (whenOutOfScreenMode == WhenOutOfScreenMode.none)
            element.deltaNone(width, height);
          else if (whenOutOfScreenMode == WhenOutOfScreenMode.Reflect)
            element.deltaReflect(width, height);
          else
            element.deltaTeleport(width, height);
        });

        linesShapes.forEach(
          (s) {
            s.forEach(
              (element) {
                if (whenOutOfScreenMode == WhenOutOfScreenMode.none)
                  element.deltaNone(width, height);
                else if (whenOutOfScreenMode == WhenOutOfScreenMode.Reflect)
                  element.deltaReflect(width, height);
                else
                  element.deltaTeleport(width, height);
              },
            );
          },
        );
      });
    });
    finishedInitilization = true;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double height = constraints.maxHeight;
        double width = constraints.maxWidth;

        if (!finishedInitilization) {
          initShapes(width, height);
          initTimer(width, height);
        }

        if (mode == VitalityMode.Randomly)
          return ClipRRect(
            child: CustomPaint(
              size: Size(width, height),
              painter: VitalityPainter(shapes, widget.background),
            ),
          );
        else
          return ClipRRect(
            child: Container(
              color: widget.background,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: width,
                    height: height / (2 * (lines + 1)),
                  ),
                  for (int i = 0; i < lines; i++) ...[
                    CustomPaint(
                      size: Size(width, height / (2 * (lines + 1))),
                      painter: VitalityPainter(linesShapes[i], null),
                    ),
                    SizedBox(
                      width: width,
                      height: height / (2 * (lines + 1)),
                    )
                  ]
                ],
              ),
            ),
          );
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
