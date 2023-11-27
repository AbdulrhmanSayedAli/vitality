# vitality

- Welcome to Vitality, a dynamic Flutter package designed to effortlessly infuse your app with captivating live animations in the background. With just 10 lines of code, you can breathe life into your UI by adding randomly moving icons, circles, rectangles, images, and more. Let's explore how you can enhance your app's visual appeal with ease.

## Examples:

Check out these examples showcasing the versatility of the Vitality library:

- ![example 1](https://github.com/AbdulrhmanSayedAli/vitality/raw/main/example/example_1.gif) ![example 2](https://github.com/AbdulrhmanSayedAli/vitality/raw/main/example/example_2.gif)

- ![example 3](https://github.com/AbdulrhmanSayedAli/vitality/raw/main/example/example_3.gif) ![example 4](https://github.com/AbdulrhmanSayedAli/vitality/raw/main/example/example_4.gif)

- ![example 5](https://github.com/AbdulrhmanSayedAli/vitality/raw/main/example/example_5.gif)

## Usage:

- The Vitality package is designed with simplicity in mind, making integration a breeze. Take a look at the example below to quickly grasp how to use it:

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

## Parameters:

- `whenOutOfScreenMode` Determines how a shape behaves at the screen edge, values are:

  - `none`: It does nothing and continues its movements out the screen.
  - `Reflect`: It bounces and returns in the oppisite direction.
  - `Teleport`: It continues its movements to the other side of the screen.

- `randomItemsBehaviours` Defines the shapes that the library can generate. Choose from the `ShapeType` enum (`FilledCircle`, `StrokeCicle`, `FilledRectangle`, `Icon`, `Image`, etc.) :

  - For `Icon` type, pass an `IconData` object:

    ```dart
     ItemBehaviour(shape: ShapeType.Icon, icon: Icons.star)
    ```

  - For `Image` type, pass a `dart:ui Image` object:

    ```dart
     ItemBehaviour(shape: ShapeType.Image, image: /*ui.Image() here*/)
    ```

    Sample code to load an image from assets:

    - Convert the path into `dart:ui Image` object

    ```dart
    import 'dart:ui' as ui;
    import 'package:flutter/services.dart';

    Future<ui.Image> loadImage(String assetPath) async {
      ByteData data = await rootBundle.load(assetPath);
      List<int> bytes = data.buffer.asUint8List();
      ui.Codec codec = await ui.instantiateImageCodec(Uint8List.fromList(bytes));
      ui.FrameInfo fi = await codec.getNextFrame();
      return fi.image;
    }
    ```

    - Integrate this function into your code :

    ```dart
    FutureBuilder<ui.Image>(
      future: loadImage('assets/images/your_image.png'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Vitality.randomly(
            whenOutOfScreenMode: WhenOutOfScreenMode.Reflect,
            randomItemsColors: const [Colors.yellow],
            randomItemsBehaviours: [
              ItemBehaviour(
                shape: ShapeType.Image,
                image: snapshot.data!,
              )
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    ),
    ```
