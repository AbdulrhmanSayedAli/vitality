# vitality

- Introducing a powerful Flutter package that lets you effortlessly create stunning live animations in the background. With just 10 lines of code, you can add randomly moving icons, circles, rectangles, and more to your app, resulting in a visually captivating experience.

## Examples

Here is some examples of using vitality library :

- ![example 1](https://github.com/AbdulrhmanSayedAli/vitalityGifs/blob/main/example_1.gif) ![example 2](https://github.com/AbdulrhmanSayedAli/vitalityGifs/blob/main/example_2.gif)

- ![example 3](https://github.com/AbdulrhmanSayedAli/vitalityGifs/blob/main/example_3.gif) ![example 4](https://github.com/AbdulrhmanSayedAli/vitalityGifs/blob/main/example_4.gif)

- ![example 5](https://github.com/AbdulrhmanSayedAli/vitalityGifs/blob/main/example_5.gif)

## usage :

- The vitality package is incredibly user-friendly, making it a breeze to incorporate into your code. Take a look at the example below to quickly grasp how to use it:

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

- The "whenOutOfScreenMode" parameter determines how a shape behaves at the screen edge :

  - <b>none</b> : It does nothing and continues its movements out the screen.
  - <b>Reflect</b> : It bounces and returns in the oppisite direction.
  - <b>Teleport</b> : It continues its movements to the other side of the screen.

- The "randomItemsBehaviours" parameter determines the shapes that the library can generate and defines the available options for generating shapes :

  - You can choose one from the ShapeType enum (FilledCircle, StrokeCicle, FilledRectangle, Icon, ...)

    ```dart
    ItemBehaviour(shape: ShapeType.StrokeCircle)
    ```

  - if you chose the icon type you also have to pass an IconData to the Item Behaviour
    ```dart
     ItemBehaviour(shape: ShapeType.Icon, icon: Icons.star)
    ```
