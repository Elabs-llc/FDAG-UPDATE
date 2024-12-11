import 'package:fdag/commons/colors/sizes.dart';
import 'package:flutter/material.dart';

/// The `ElColor` class provides a collection of predefined colors and gradients for use throughout the app.
/// It includes custom text styles, gradients, and various theme colors such as primary, secondary,
/// background, and button colors. The class aims to centralize color management, ensuring consistency
/// across the application's design and theming.
///
/// ### Custom Text Styles:
///
/// - `yellowColor`: A text style with a yellow color (`Color.fromARGB(255, 149, 226, 5)`) and font size of 15.0.
/// - `whiteColor`: A text style with white color and font size of 15.0.
/// - `whiteColor2`: A text style with white color and font size set to `Sizes.f3`.
/// - `blackColor2`: A text style with dark blue color and font size set to `Sizes.fontSizeMd`.
/// - `blackColor3`: A text style with black color and font size set to `Sizes.fontSizeSm`.
///
/// ### Gradients:
///
/// - `gradientSplash`: A linear gradient transitioning from dark blue (`Color.fromARGB(255, 0, 0, 128)`)
///   to gold, and then to red, typically used for splash screens or dynamic backgrounds.
///
/// ### General Colors:
///
/// - `red`: Bright red color (`Color.fromARGB(255, 255, 0, 0)`).
/// - `gold`: Golden yellow color (`Color.fromARGB(255, 255, 215, 0)`).
/// - `darkBlue`: Deep blue color (`Color.fromARGB(255, 0, 0, 128)`).
/// - `transparent`: Transparent color.
///
/// ### Theme Colors:
///
/// - `primary`: Primary color used for major UI elements (`Color.fromARGB(255, 0, 0, 128)`).
/// - `secondary`: Secondary color (`Color(0xFFFFE24B)`), used for accents or highlights.
/// - `accent`: Accent color (`Color(0xFFb0c7ff)`), used to complement the primary color.
///
/// ### Text Colors:
///
/// - `textPrimary`: Primary text color (`Color(0xFF333333)`), typically for headings or prominent text.
/// - `textSecondary`: Secondary text color (`Color(0xFF6C757D)`), used for less prominent text.
/// - `textWhite`: White text color (`Colors.white`).
///
/// ### Background Colors:
///
/// - `light`: Light background color (`Color(0xFFF6F6F6)`).
/// - `dark`: Dark background color (`Color(0xFF272727)`).
/// - `primaryBackground`: Primary background color for major sections (`Color(0xFFF3F5FF)`).
///
/// ### Button Colors:
///
/// - `buttonPrimary`: Primary button color (`Color(0xFF4b68ff)`).
/// - `buttonSecondary`: Secondary button color (`Color(0xFF6C757D)`).
/// - `buttonDisabled`: Disabled button color (`Color(0xFFC4C4C4)`).
///
/// ### Border Colors:
///
/// - `borderPrimary`: Primary border color (`Color(0xFFD9D9D9)`).
/// - `borderSecondary`: Secondary border color (`Color(0xFFE6E6E6)`).
///
/// ### Error and Validation Colors:
///
/// - `error`: Error color (`Color(0xFFD32F2F)`), typically used for validation errors.
/// - `success`: Success color (`Color(0xFF388E3C)`), used to indicate successful actions.
/// - `warning`: Warning color (`Color(0xFFF57C00)`), used to indicate caution.
/// - `info`: Informational color (`Color(0xFF1976D2)`), used to display additional information.
///
/// ### Neutral Shades:
///
/// - Various shades of grey and neutral colors (`black`, `darkerGrey`, `darkGrey`, `grey`, `lightGrey`, `white`)
///   for background, borders, and less prominent UI elements.
///
/// This class helps ensure a consistent and organized approach to color use across the entire application.
class ElColor {
  // custom
  static var yellowCo9lor =
      TextStyle(color: Color.fromARGB(255, 149, 226, 5), fontSize: 15.0);

  static var whiteColor = TextStyle(color: Colors.white, fontSize: 15.0);
  static var whiteColor2 = TextStyle(color: Colors.white, fontSize: Sizes.f3);

  static var blackColor2 = TextStyle(
      color: ElColor.darkBlue,
      fontSize: Sizes.fontSizeMd,
      fontWeight: FontWeight.w700);
  static var blackColor3 =
      TextStyle(color: Colors.black, fontSize: Sizes.fontSizeSm);

  static var gradientSplash = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.blue[400]!,
        Colors.purple[500]!,
      ]);
  // general colors
  static const Color red = Color.fromARGB(255, 255, 0, 0);
  static const Color gold = Color.fromARGB(255, 255, 215, 0);
  static const Color darkBlue = Color.fromARGB(255, 0, 0, 128);
  static const Color darkBlue500 = Color.fromARGB(75, 0, 0, 128);
  static const Color darkBlue200 = Color.fromARGB(38, 0, 0, 128);
  static const Color darkBlue100 = Color.fromARGB(0, 0, 0, 128);
  static const Color transparent = Colors.transparent;

  // App theme colors
  static const Color primary = Color.fromARGB(255, 0, 0, 128);
  static const Color secondary = Color(0xFFFFE24B);
  static const Color accent = Color(0xFFb0c7ff);

  // Text colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textWhite = Colors.white;

  // Background colors
  static const Color light = Color(0xFFF6F6F6);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBackground = Color(0xFFF3F5FF);

  // Background Container colors
  static const Color lightContainer = Color(0xFFF6F6F6);
  static Color darkContainer = ElColor.white.withOpacity(0.1);

  // Button colors
  static const Color buttonPrimary = Color(0xFF4b68ff);
  static const Color buttonSecondary = Color(0xFF6C757D);
  static const Color buttonDisabled = Color(0xFFC4C4C4);

  // Border colors
  static const Color borderPrimary = Color(0xFFD9D9D9);
  static const Color borderSecondary = Color(0xFFE6E6E6);

  // Error and validation colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);

  // Neutral Shades
  static const Color black = Color(0xFF232323);
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0xFFF4F4F4);
  static const Color lightGrey = Color(0xFFF9F9F9);
  static const Color white = Color(0xFFFFFFFF);
}
