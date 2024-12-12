import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

enum SnackBarType { success, error, info }

class UiHelper {
  UiHelper._();

  /// Displays a [SnackBar] with the given [message] in the provided [context].
  ///
  /// The [context] parameter is used to find the nearest [ScaffoldMessenger].

  static void showSnackBar(BuildContext context, String message,
      {SnackBarType type = SnackBarType.info}) {
    Color backgroundColor;
    IconData icon;

    switch (type) {
      case SnackBarType.success:
        backgroundColor = Colors.green;
        icon = Icons.check_circle;
        break;
      case SnackBarType.error:
        backgroundColor = Colors.red;
        icon = Icons.error;
        break;
      case SnackBarType.info:
        backgroundColor = Colors.blue;
        icon = Icons.info;
        break;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(10),
      ),
    );

    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text(message),
    // ));
  }

  /// Sets the application to full-screen immersive mode.
  ///
  /// This hides all system overlays (e.g., status bar, navigation bar).
  static void setFullScreen() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersive,
      overlays: [],
    );
  }

  /// Restores the system UI to its default state.
  ///
  /// This shows all system overlays (e.g., status bar, navigation bar).
  static void restoreSystemUI() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  /// Sets the preferred device orientation.
  ///
  /// The [orientation] parameter specifies the desired orientation.
  /// The default value is [DeviceOrientation.portraitUp].
  static void setPreferredOrientations(
      {DeviceOrientation orientation = DeviceOrientation.portraitUp}) {
    SystemChrome.setPreferredOrientations([
      orientation,
    ]);
  }
}
