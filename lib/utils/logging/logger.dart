import 'dart:developer' as developer;

import 'package:flutter/material.dart';

/// A simple logging utility for this application
///
/// This class provides methods to log messages with different severity levels,
/// allowing developers to filter logs based on their importance. The logs can
/// be output to the console as well as the Dart developer tool.
class Logger {
  // Log levels
  static const String _levelDebug = 'DEBUG';
  static const String _levelInfo = 'INFO';
  static const String _levelWarning = 'WARNING';
  static const String _levelError = 'ERROR';

  /// The current log level (you can set it to a higher level to filter logs).
  static String logLevel = _levelDebug;

  /// Logs a debug message.
  ///
  /// Only logs if the current log level is set to DEBUG or lower.
  ///
  /// Parameters:
  /// - [message]: The debug message to log.
  static void debug(String message) {
    if (_shouldLog(_levelDebug)) {
      _log(_levelDebug, message);
    }
  }

  /// Logs an informational message.
  ///
  /// Only logs if the current log level is set to INFO or lower.
  ///
  /// Parameters:
  /// - [message]: The informational message to log.
  static void info(String message) {
    if (_shouldLog(_levelInfo)) {
      _log(_levelInfo, message);
    }
  }

  /// Logs a warning message.
  ///
  /// Only logs if the current log level is set to WARNING or lower.
  ///
  /// Parameters:
  /// - [message]: The warning message to log.
  static void warning(String message) {
    if (_shouldLog(_levelWarning)) {
      _log(_levelWarning, message);
    }
  }

  /// Logs an error message.
  ///
  /// Only logs if the current log level is set to ERROR or lower.
  ///
  /// Parameters:
  /// - [message]: The error message to log.
  static void error(String message) {
    if (_shouldLog(_levelError)) {
      _log(_levelError, message);
    }
  }

  /// Checks if the message should be logged based on the current log level.
  ///
  /// Parameters:
  /// - [level]: The log level to check against the current log level.
  ///
  /// Returns:
  /// - A boolean indicating whether the message should be logged.
  static bool _shouldLog(String level) {
    const levels = [_levelDebug, _levelInfo, _levelWarning, _levelError];
    return levels.indexOf(level) >= levels.indexOf(logLevel);
  }

  /// Actual logging method that formats and outputs the log message with the current time.
  ///
  /// Parameters:
  /// - [level]: The severity level of the log message.
  /// - [message]: The message to log.
  static void _log(String level, String message) {
    final timeStamp = DateTime.now().toIso8601String();
    final logMessage = '[$timeStamp] [$level] $message';
    developer.log(logMessage);
    // Optionally, you can also print to console
    debugPrint(logMessage);
  }
}
