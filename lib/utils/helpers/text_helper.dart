import 'package:intl/intl.dart';

/// The `TextHelper` class provides utility methods for handling and manipulating text.
///
/// This class is not meant to be instantiated and contains only static methods for text manipulation.
///
/// ### Methods:
///
/// - [truncateText]: Truncates a given string to a specified length and adds an ellipsis ("...") if the text exceeds the length.
///
/// ### Example Usage:
/// ```dart
/// // Truncate text to a maximum of 30 characters
/// String shortenedText = TextHelper.truncateText("This is a very long text that needs truncating", length: 30);
/// ```
///
/// ### Method Details:
///
/// #### `truncateText`
///
/// - Parameters:
///   - `text`: The original string that needs to be truncated.
///   - `length`: The maximum length of the truncated string, including the ellipsis. Defaults to 50 characters.
/// - Returns:
///   - If the original string's length is less than or equal to the specified `length`, the original text is returned.
///   - Otherwise, the string is truncated to the specified length and appended with an ellipsis ("...").
///
/// ```dart
/// // Example
/// TextHelper.truncateText("A very long sentence", length: 10); // Returns: "A very lo..."
/// ```
class TextHelper {
  TextHelper._();

  /// Truncates the given [text] to a maximum length of [length] characters.
  ///
  /// - [text]: The string to be truncated.
  /// - [length]: The maximum length of the truncated string, including the ellipsis. Defaults to 50.
  ///
  /// If the text is shorter than or equal to [length], the original text is returned.
  /// If the text exceeds the [length], the string is truncated, and an ellipsis ("...") is appended.
  ///
  /// Example:
  /// ```dart
  /// String shortText = TextHelper.truncateText("This is a long text", length: 10);
  /// // Result: "This is a..."
  /// ```
  static String truncateText(String text, {int length = 50}) {
    if (text.length <= length) return text;
    return '${text.substring(0, length)}...';
  }

  static String formatDate(String inputDate) {
    try {
      // Parse the input date in "DD/MM/YYYY" format
      DateTime dateTime = DateFormat('dd/MM/yyyy').parse(inputDate);

      // Format the date into "MMM dd, yyyy"
      String formattedDate = DateFormat('MMM dd, yyyy').format(dateTime);

      return formattedDate;
    } catch (e) {
      // Handle errors if the input date is invalid
      return 'Invalid date';
    }
  }

  static String getYear(String inputDate) {
    try {
      // Parse the input date in "DD/MM/YYYY" format
      DateTime dateTime = DateFormat('dd/MM/yyyy').parse(inputDate);

      // Extract the year from the date
      String year = DateFormat('yyyy').format(dateTime);

      return year;
    } catch (e) {
      // Handle errors if the input date is invalid
      return 'Invalid date';
    }
  }

  static String formatDateTime(DateTime? date) {
    if (date == null) {
      return 'N/A'; // Default value for null dates
    }
    return DateFormat('dd/MM/yyyy').format(date); // Format as DD/MM/YYYY
  }
}
