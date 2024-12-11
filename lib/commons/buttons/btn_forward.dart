import 'package:flutter/material.dart';

/// A helper function that creates a forward button using an `IconButton` widget.
/// This button allows the user to navigate to the next page in a `PageView` widget.
///
/// ### Parameters:
///
/// - `context`: The `BuildContext` for the current widget tree.
/// - `controller`: A `PageController` that controls which page is visible in the `PageView`.
///   The button triggers a transition to the next page when pressed.
///
/// ### Behavior:
///
/// When pressed, the button navigates to the next page with an animation that lasts
/// 300 milliseconds using the `Curves.easeIn` curve for a smooth transition effect.
///
/// ### Example Usage:
/// ```dart
/// btnForward(context, pageController);
/// ```
///
/// This can be used in a `Scaffold` to provide forward navigation functionality within a `PageView`.
Widget btnForward(BuildContext context, PageController controller) {
  return IconButton(
    icon: const Icon(Icons.arrow_forward_ios_rounded),
    onPressed: () {
      controller.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    },
  );
}
