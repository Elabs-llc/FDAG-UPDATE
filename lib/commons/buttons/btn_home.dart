import 'package:flutter/material.dart';

/// A helper function that creates a circular "Home" button using an `ElevatedButton` widget.
/// This button navigates the user to the `/home` route when pressed.
///
/// ### Parameters:
///
/// - `context`: The `BuildContext` for the current widget tree, used to perform navigation.
///
/// ### Behavior:
///
/// When pressed, the button navigates the user to the `/home` route by calling `Navigator.popAndPushNamed`,
/// which first removes the current route and then navigates to the `/home` route.
///
/// ### Styling:
///
/// - The button has a yellow background color.
/// - The button's shape is a circular button created using `CircleBorder()`.
///
/// ### Example Usage:
/// ```dart
/// btnHome(context);
/// ```
///
/// This button can be used to navigate the user to the home screen with a single press.
Widget btnHome(BuildContext context, VoidCallback onIntroComplete) {
  return ElevatedButton(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Colors.yellow),
      shape: WidgetStatePropertyAll(CircleBorder()),
    ),
    onPressed: () {
      Navigator.popAndPushNamed(context, '/home');
    },
    child: Icon(Icons.arrow_forward_ios_rounded),
  );
}
