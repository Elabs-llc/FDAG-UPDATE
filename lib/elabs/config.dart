/// The `Config` class contains static constant values used throughout the application
/// for configuring text displayed in various sections such as bottom navigation labels,
/// default headers, and descriptions.
///
/// This class cannot be instantiated as it only contains static constants.
///
/// ### Constants:
///
/// - [bottomNavHomeText]: The label for the "Home" section in the bottom navigation bar.
/// - [bottomNavGalleryText]: The label for the "Gallery" section in the bottom navigation bar.
/// - [bottomNavMVText]: The label for the "Mission & Vision" section in the bottom navigation bar.
/// - [bottomNavByText]: The label for the "By-Laws" section in the bottom navigation bar.
/// - [defaultHead]: The default heading for pages related to "Elabs LLC".
/// - [defaultText]: A default description text explaining the mission, expertise, and innovation of Elabs LLC.
/// - [remarkText]: The title used for "Chair Person Remarks" section.
///
/// ### Usage:
/// This class provides a centralized place to manage text values across the app, making it easier
/// to maintain and update text without hardcoding strings in various parts of the UI.
///
/// ### Example:
/// ```dart
/// // Accessing configuration values
/// String homeText = Config.bottomNavHomeText;
/// String heading = Config.defaultHead;
/// ```
class Config {
  Config._();

  static const String bottomNavHomeText = "Home";
  static const String bottomNavGalleryText = "Gallery";
  static const String bottomNavMVText = "Mission & Vission";
  static const String bottomNavByText = "By-Laws";

  static const String defaultHead = "Elabs LLC";

  static const String defaultText =
      "Elabs is a dynamic technology company focused on leveraging cutting-edge solutions to solve real-world problems. With expertise in web and mobile app development, software engineering, and a strong passion for AI/ML, Elabs is committed to innovation and delivering high-quality, impactful results. Driven by a mission to continuously learn and evolve, Elabs empowers businesses and individuals through tailored technology solutions.";

  static const String defaultSectionTitle = "Elabs LLC";
  static const String remarkText = "Chair Person Remarks";
  static const String read_more = "READ MORE";
  static const String event_title = "Events";
  static const String latest_news_title = "News & Updates";
  static const String spotlight_title = "Spotlights";
}
