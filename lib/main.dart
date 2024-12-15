import 'package:fdag/el.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

/// The `El` widget is responsible for setting up the app's structure, theme,
/// and initial screen.
///
/// This is the starting point for the Flutter app lifecycle.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: const El()));

  /// The entry point of the application.
  ///
  /// This function initializes the app by calling `runApp()` and passing an instance
  /// of the `El` widget, which serves as the root of the application.
  // runApp(const El());
}
