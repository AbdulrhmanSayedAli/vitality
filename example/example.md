- vitality package is very easy to use you can understand its usage in the code below :

```dart
Vitality.randomly(
  background: Colors.black,
  maxOpacity: 0.8,
  minOpacity: 0.3,
  itemsCount: 80,
  enableXMovements: false,
  whenOutOfScreenMode: WhenOutOfScreenMode.Teleport,
  maxSpeed: 1.5,
  maxSize: 30,
  minSpeed: 0.5,
  randomItemsColors: [Colors.yellowAccent, Colors.white],
  randomItemsBehaviours: [
    ItemBehaviour(shape: ShapeType.Icon, icon: Icons.star),
    ItemBehaviour(shape: ShapeType.Icon, icon: Icons.star_border),
    ItemBehaviour(shape: ShapeType.StrokeCircle),
  ],
)
```

- Full Customization :

```dart
List<Shape> getClouds(Size size) {
  return ShapesGenerator.randomly(
    maxWidth: size.width,
    maxHeight: size.height / 3,
    enableYMovements: false,
    maxSize: 60,
    minSize: 50,
    maxOpacity: 0.9,
    minOpacity: 0.5,
    whenOutOfScreenMode: WhenOutOfScreenMode.Reflect,
    behaviours: [ItemBehaviour(shape: ShapeType.Icon, icon: Icons.cloud)],
    colors: const [Colors.white],
  ).getShapes(10);
}

List<Shape> getGroundShapes(Size size) {
  return ShapesGenerator.randomly(
    minHeight: size.height - 130,
    maxWidth: size.width,
    maxHeight: size.height,
    enableYMovements: false,
    maxSize: 190,
    minSize: 90,
    maxOpacity: 1,
    minOpacity: 0.5,
    whenOutOfScreenMode: WhenOutOfScreenMode.none,
    behaviours: [
      ItemBehaviour(shape: ShapeType.Icon, icon: Icons.circle)
    ],
    colors: const [Colors.green],
    maxSpeed: 0,
    minSpeed: 0
  ).getShapes(40);
}



@override
Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Vitality.custom(background: Colors.blue, shapes: [
    Shape(
      pos: const Offset(30, 30),
      dx: 0.3,
      dy: 0,
      size: 160,
      color: Colors.yellow,
      whenOutOfScreenMode: WhenOutOfScreenMode.Reflect,
      behaviour: ItemBehaviour(shape: ShapeType.Icon, icon: Icons.sunny),
    ),
    ...getClouds(size),
    ...getGroundShapes(size),
  ]);
}
```
