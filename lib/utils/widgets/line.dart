import 'package:fdag/commons/colors/el_color.dart';
import 'package:fdag/commons/colors/sizes.dart';
import 'package:flutter/material.dart';

/// The `Line` class provides utility widgets to create horizontal and vertical lines,
/// as well as customizable spacing within Flutter layouts.
///
/// This class contains only static methods, so it cannot be instantiated.
/// It is used to draw lines with specified dimensions and colors, or to add space between elements.
///
/// ### Methods:
///
/// - [horizontalLine]: Returns a horizontal line of customizable width, height, and color.
/// - [verticalLine]: Returns a vertical line of customizable width, height, and color.
/// - [space]: Returns an empty space with customizable width and height.
///
/// ### Default Values:
/// - The default width and height are defined in `Sizes` constants.
/// - The default color for both lines is `ElColor.darkBlue`.
///
/// ### Example Usage:
/// ```dart
/// // Create a horizontal line with a width of 100 and a height of 2
/// Line.horizontalLine(width: 100, height: 2, color: Colors.black);
///
/// // Create a vertical line with default sizes
/// Line.verticalLine();
///
/// // Add space with a width of 16 and height of 8
/// Line.space(width: 16, height: 8);
/// ```
class Line {
  Line._();

  /// Creates a horizontal line.
  ///
  /// - [width]: The width of the line. Defaults to `Sizes.md`.
  /// - [height]: The thickness (height) of the line. Defaults to `Sizes.xs`.
  /// - [color]: The color of the line. Defaults to `ElColor.darkBlue`.
  ///
  /// Returns a `SizedBox` containing a `ColoredBox` with the specified width, height, and color.
  static Widget horizontalLine(
      {double width = Sizes.md,
      double height = Sizes.xs,
      Color color = ElColor.darkBlue}) {
    return SizedBox(
      width: width,
      height: height,
      child: ColoredBox(
        color: color,
      ),
    );
  }

  /// Creates a vertical line.
  ///
  /// - [width]: The thickness (width) of the line. Defaults to `Sizes.xs`.
  /// - [height]: The height of the line. Defaults to `Sizes.md`.
  /// - [color]: The color of the line. Defaults to `ElColor.darkBlue`.
  ///
  /// Returns a `SizedBox` containing a `ColoredBox` with the specified width, height, and color.
  static Widget verticalLine(
      {double width = Sizes.xs,
      double height = Sizes.md,
      Color color = ElColor.darkBlue}) {
    return SizedBox(
      width: width,
      height: height,
      child: ColoredBox(
        color: color,
      ),
    );
  }

  /// Creates an empty space of specified width and height.
  ///
  /// - [width]: The width of the space. Defaults to `Sizes.md`.
  /// - [height]: The height of the space. Defaults to `0`.
  ///
  /// Returns a `SizedBox` with the specified width and height.
  static Widget space({double width = Sizes.md, double height = 0}) {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}
