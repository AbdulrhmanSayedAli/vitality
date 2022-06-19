* vitality package is very easy to use you can understand its usage in the code below :

```dart
Vitality.randomly(
                height: size.height,
                width: size.width,
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