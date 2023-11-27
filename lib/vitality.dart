library vitality;

export 'shapesManagement/Shape.dart';
export 'shapesManagement/ShapesGenerator.dart';
export 'models/WhenOutOfScreenMode.dart';
export 'models/ItemBehaviour.dart';

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'models/ItemBehaviour.dart';
import 'models/WhenOutOfScreenMode.dart';
import 'models/vitalityMode.dart';
import 'painting/Painter.dart';
import 'shapesManagement/Shape.dart';
import 'shapesManagement/ShapesGenerator.dart';

const int DefaultItemsCount = 60;
const int DefaultLines = 5;
const double DefaultmaxSize = 50;
const double DefaultminSize = 5;
const double DefaultmaxOpacity = 0.8;
const double DefaultminOpacity = 0.1;
const double DefaultmaxSpeed = 1;
const double DefaultminSpeed = 0;
const bool DefaultenableXMovements = true;
const bool DefaultenableYMovements = true;
const WhenOutOfScreenMode DefaultwhenOutOfScreenMode = WhenOutOfScreenMode.none;

// ignore: must_be_immutable
class Vitality extends StatefulWidget {
  int itemsCount = DefaultItemsCount;
  double maxOpacity = DefaultmaxOpacity;
  double minOpacity = DefaultminOpacity;
  double maxSize = DefaultmaxSize;
  double minSize = DefaultminSize;
  double maxSpeed = DefaultmaxSpeed;
  double minSpeed = DefaultminSpeed;
  bool enableXMovements = DefaultenableXMovements;
  bool enableYMovements = DefaultenableYMovements;
  WhenOutOfScreenMode whenOutOfScreenMode = DefaultwhenOutOfScreenMode;
  List<ItemBehaviour> randomItemsBehaviours = [];
  List<Color> randomItemsColors = [];
  int lines = DefaultLines;
  List<Shape> shapes = [];
  late VitalityMode mode;
  Color? background;

  Vitality.randomly(
      {this.itemsCount = DefaultItemsCount,
      this.maxSize = DefaultmaxSize,
      this.minSize = DefaultminSize,
      this.enableXMovements = DefaultenableXMovements,
      this.enableYMovements = DefaultenableYMovements,
      this.maxOpacity = DefaultmaxOpacity,
      this.minOpacity = DefaultminOpacity,
      this.maxSpeed = DefaultmaxSpeed,
      this.minSpeed = DefaultminSpeed,
      this.whenOutOfScreenMode = DefaultwhenOutOfScreenMode,
      required this.randomItemsBehaviours,
      required this.randomItemsColors,
      Key? key,
      this.background})
      : super(key: key) {
    mode = VitalityMode.Randomly;
  }

  Vitality.custom(
      {required this.shapes,
      this.whenOutOfScreenMode = WhenOutOfScreenMode.none,
      Key? key,
      this.background})
      : super(key: key) {
    mode = VitalityMode.Custom;
  }

  Vitality.lines(
      {Key? key,
      this.maxOpacity = DefaultmaxOpacity,
      this.minOpacity = DefaultminOpacity,
      this.maxSpeed = DefaultmaxSpeed,
      this.minSpeed = DefaultminSpeed,
      this.lines = DefaultLines,
      required this.randomItemsBehaviours,
      required this.randomItemsColors,
      this.background})
      : super(key: key) {
    mode = VitalityMode.Lines;
    whenOutOfScreenMode = WhenOutOfScreenMode.Teleport;
  }

  @override
  _VitalityState createState() => _VitalityState(
      maxSpeed: maxSpeed,
      minSpeed: minSpeed,
      count: itemsCount,
      enableXMovements: enableXMovements,
      enableYMovements: enableYMovements,
      maxSize: maxSize,
      minSize: minSize,
      randomItemsBehaviours: randomItemsBehaviours,
      whenOutOfScreenMode: whenOutOfScreenMode,
      mode: mode,
      lines: lines,
      randomItemsColors: randomItemsColors,
      maxOpacity: min(maxOpacity, 1),
      minOpacity: max(minOpacity, 0),
      shapes: shapes);
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
  List<List<Shape>> linesShapes = [];
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
    this.shapes = const [],
  });

  void initShapes(double width, double height) {
    generator = ShapesGenerator.randomly(
        minHeight: 0,
        minWidth: 0,
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
        whenOutOfScreenMode: whenOutOfScreenMode);

    shapes = generator.getShapes(count);

    linesShapes =
        List.generate(lines, (index) => generator.getLinesShapes(lines));
  }

  void initTimer(double width, double height) {
    timer = Timer.periodic(Duration(milliseconds: 1000 ~/ 60), (t) {
      setState(() {
        shapes.forEach((element) {
          element.delta(width, height);
        });

        linesShapes.forEach(
          (s) {
            s.forEach(
              (element) {
                element.delta(width, height);
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
          if (shapes.isEmpty || linesShapes.isEmpty) initShapes(width, height);
          initTimer(width, height);
          print(linesShapes);
        }

        if (mode == VitalityMode.Randomly || mode == VitalityMode.Custom)
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
