# vitality

* A Flutter package that Allows you to create a very beautiful live animations in the background (like randomly moving icons ,circles ,rectangles ....) within 10 lines.

## Examples 

Here is some examples of using vitality library :

* ![example 1](https://github.com/AbdulrhmanSayedAli/vitality/blob/main/example/example_1.gif) ![example 2](https://github.com/AbdulrhmanSayedAli/vitality/blob/main/example/example_2.gif)

* ![example 3](https://github.com/AbdulrhmanSayedAli/vitality/blob/main/example/example_3.gif) ![example 4](https://github.com/AbdulrhmanSayedAli/vitality/blob/main/example/example_4.gif)

* ![example 5](https://github.com/AbdulrhmanSayedAli/vitality/blob/main/example/example_5.gif)


## usage :

* vitality package is very easy to use you cane understand its usage in the code below :

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

* <b>Note!! :</b> Do not pass double.infinty to the width or hight use MediaQuery instead :
    ```dart
       Size size = MediaQuery.of(context).size;
        ...
        Vitality.randomly(
                height: size.height,
                width: size.width,
                ...
                )
    ```
 

* the whenOutOfScreenMode defines what should the shape do when it reaches the screen edge :
    - <b>none</b> : it does nothing and continues its movements out the screen.
    - <b>Reflect</b> : it bounces and returns in the oppisite direction.
    - <b>Teleprt</b> : it continues its movements to the other side of the screen.

* the randomItemsBehaviours defines what available shapes can the library generate :
    - you can chose one from the ShapeType enum (FilledCircle, StrokeCicle, FilledRectangle, icon, ...)

         ```dart
        ItemBehaviour(shape: ShapeType.StrokeCircle)
        ```
    - if you chose the icon type you also have to pass an IconDate to the Item Behaviour
        ```dart
         ItemBehaviour(shape: ShapeType.Icon, icon: Icons.star)
        ```

