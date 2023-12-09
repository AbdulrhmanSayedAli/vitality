# Changelog

All notable changes to this package will be documented in this file.

## 1.0.1

- A Flutter package that Allows you to create a very beautiful live animations in the background (like randomly moving icons ,circles ,rectangles ....) within 10 lines.

- added the randomly generated animations with a custom settings chosen by you (like make the movements vertically only, determine minimum and maximum speed, size, opacity ...).

- added the lines generated animation which gives animated queues if shapes with number of lines determined by you.

## 1.0.2

- Fixing error : "Unsupported operation: Cannot modify an unmodifiable list" error when passing a const array of colors

## 1.0.3 [Retracted Version]

- Improving performance

## 1.0.4

- Fixing error : "App error: setState() called after dispose():VitalityState#eee0e(lifecycle state: defunct, not mounted)"

## 2.0.0

- Removing the required width and height properties (Vitality will now take the parent's width and height).
- Improving performance.
- Fixing the error: sometimes the animations freeze.

## 2.1.0

- Enhancing functionality by introducing the capability to draw not only icons and shapes but also images.

## 3.0.0

- Introduced a custom mode option to enhance specific customization capabilities.
- Implemented minimum height and width parameters in the `ShapesGenerator` for greater control.
- Most `ShapesGenerator` parameters is no longer required.
- Renamed all `ShapeType` names from triangle to square.
- Eliminate the need to import individual files, simply import the main library file.
- Documenting part of the code to make it clearer and easier to understand.
