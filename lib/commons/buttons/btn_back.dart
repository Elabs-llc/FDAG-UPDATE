import 'package:flutter/material.dart';

/// A helper function that creates a back button using an `IconButton` widget.
/// This button allows the user to navigate to the previous page in a `PageView` widget.
///
/// ### Parameters:
///
/// - `context`: The `BuildContext` for the current widget tree.
/// - `controller`: A `PageController` that controls which page is visible in the `PageView`.
///   The button triggers a transition to the previous page when pressed.
///
/// ### Behavior:
///
/// When pressed, the button navigates to the previous page with an animation that lasts
/// 300 milliseconds using the `Curves.bounceIn` curve for a dynamic bounce effect.
///
/// ### Example Usage:
/// ```dart
/// btnBack(context, pageController);
/// ```
///
/// This can be used in a `Scaffold` to provide backward navigation functionality within a `PageView`.
Widget btnBack(BuildContext context, PageController controller) {
  return IconButton(
    icon: const Icon(Icons.arrow_back_ios_rounded),
    onPressed: () {
      controller.previousPage(
          duration: Duration(milliseconds: 300), curve: Curves.bounceIn);
    },
  );
}
