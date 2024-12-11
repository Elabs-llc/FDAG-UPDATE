/// The `Sizes` class provides a centralized collection of commonly used size values
/// such as font sizes, padding, margins, button dimensions, and other UI element sizes.
///
/// This class defines static constants and variables that are used throughout the application
/// to maintain consistency and scalability across the UI.
///
/// ### Variables:
///
/// - `f01` to `f20`: Incremental floating-point values, typically used for spacing or element sizes.
///
/// ### Constants:
///
/// - **Padding and Margin Sizes:**
///   - `xs`: Extra small padding/margin (4.0).
///   - `sm`: Small padding/margin (8.0).
///   - `md`: Medium padding/margin (16.0).
///   - `lg`: Large padding/margin (24.0).
///   - `xl`: Extra large padding/margin (32.0).
///
/// - **Icon Sizes:**
///   - `iconXs`: Extra small icon size (12.0).
///   - `iconSm`: Small icon size (16.0).
///   - `iconMd`: Medium icon size (24.0).
///   - `iconLg`: Large icon size (32.0).
///
/// - **Font Sizes:**
///   - `fontSizeSm`: Small font size (14.0).
///   - `fontSizeMd`: Medium font size (16.0).
///   - `fontSizeLg`: Large font size (18.0).
///
/// - **Button Sizes:**
///   - `buttonHeight`: Height of buttons (18.0).
///   - `buttonRadius`: Button corner radius (12.0).
///   - `buttonWidth`: Button width (120.0).
///   - `buttonElevation`: Elevation for raised buttons (4.0).
///
/// - **AppBar Height:**
///   - `appBarHeight`: Default AppBar height (56.0).
///
/// - **Image Sizes:**
///   - `imageThumbSize`: Thumbnail image size (80.0).
///
/// - **Spacing Between Sections:**
///   - `defaultSpace`: Default space between sections (24.0).
///   - `spaceBtwItems`: Space between items (16.0).
///   - `spaceBtwSections`: Space between sections (32.0).
///
/// - **Border Radius:**
///   - `borderRadiusSm`: Small border radius (4.0).
///   - `borderRadiusMd`: Medium border radius (8.0).
///   - `borderRadiusLg`: Large border radius (12.0).
///
/// - **Divider Height:**
///   - `dividerHeight`: Height of dividers (1.0).
///
/// - **Input Field Dimensions:**
///   - `inputFieldRadius`: Radius for input fields (12.0).
///   - `spaceBtwInputFields`: Space between input fields (16.0).
///
/// - **Card Sizes:**
///   - `cardRadiusLg`: Large card corner radius (16.0).
///   - `cardRadiusMd`: Medium card corner radius (12.0).
///   - `cardRadiusSm`: Small card corner radius (10.0).
///   - `cardRadiusXs`: Extra small card corner radius (6.0).
///   - `cardElevation`: Elevation for cards (2.0).
///
/// - **Loading Indicator Size:**
///   - `loadingIndicatorSize`: Size of loading indicators (36.0).
///
/// - **Grid View Spacing:**
///   - `gridViewSpacing`: Spacing between items in grid views (16.0).
///
/// ### Example Usage:
/// ```dart
/// // Using Sizes for padding and font sizes
/// padding: EdgeInsets.all(Sizes.md),
/// fontSize: Sizes.fontSizeMd,
///
/// // Button dimensions
/// height: Sizes.buttonHeight,
/// radius: Sizes.buttonRadius,
/// ```
class Sizes {
  // Dynamic spacing and sizing
  static int f0 = 0;
  static var f01 = 5.0;
  static var f001 = 10.0;
  static var f1 = 15.0;
  static var f2 = 20.0;
  static var f3 = 25.0;
  static var f4 = 30.0;
  static var f5 = 35.0;
  static var f6 = 40.0;
  static var f7 = 45.0;
  static var f8 = 50.0;
  static var f9 = 55.0;
  static var f10 = 60.0;
  static var f11 = 65.0;
  static var f12 = 70.0;
  static var f13 = 75.0;
  static var f14 = 80.0;
  static var f15 = 85.0;
  static var f16 = 90.0;
  static var f17 = 95.0;
  static var f18 = 100.0;
  static var f19 = 105.0;
  static var f20 = 110.0;

  // Padding and margin sizes
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;

  // Icon sizes
  static const double iconXs = 12.0;
  static const double iconSm = 16.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;

  // Font sizes
  static const double fontSizeSm = 14.0;
  static const double fontSizeMd = 16.0;
  static const double fontSizeLg = 18.0;

  // Button sizes
  static const double buttonHeight = 18.0;
  static const double buttonRadius = 12.0;
  static const double buttonWidth = 120.0;
  static const double buttonElevation = 4.0;

  // AppBar height
  static const double appBarHeight = 56.0;

  // Image sizes
  static const double imageThumbSize = 80.0;

  // Default spacing between sections
  static const double defaultSpace = 24.0;
  static const double spaceBtwItems = 16.0;
  static const double spaceBtwSections = 32.0;

  // Border radius
  static const double borderRadiusSm = 4.0;
  static const double borderRadiusMd = 8.0;
  static const double borderRadiusLg = 12.0;

  // Divider height
  static const double dividerHeight = 1.0;

  // Input field
  static const double inputFieldRadius = 12.0;
  static const double spaceBtwInputFields = 16.0;

  // Card sizes
  static const double cardRadiusLg = 16.0;
  static const double cardRadiusMd = 12.0;
  static const double cardRadiusSm = 10.0;
  static const double cardRadiusXs = 6.0;
  static const double cardElevation = 2.0;

  // Loading indicator size
  static const double loadingIndicatorSize = 36.0;

  // Grid view spacing
  static const double gridViewSpacing = 16.0;
}
