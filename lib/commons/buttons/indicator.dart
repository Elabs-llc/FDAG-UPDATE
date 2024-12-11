import 'package:fdag/commons/colors/sizes.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
/// The `Indicator` widget represents a customizable page indicator that tracks the current page
/// in a `PageView` using a series of circular dots. The active dot changes color when the page changes.
///
/// ### Parameters:
///
/// - `controller`: A `PageController` that controls which page is currently displayed in the `PageView`.
/// - `count`: The total number of pages in the `PageView` to create the corresponding number of indicator dots.
///
/// This widget listens to page changes using the provided `PageController` and updates the UI to reflect
/// the currently active page by highlighting the corresponding dot.
///
/// ### Behavior:
///
/// - A horizontal list of circular dots is displayed.
/// - The currently active page is highlighted with a yellow color (`Color.fromARGB(255, 229, 233, 1)`), while the other dots are grey.
/// - The widget listens for page navigation changes and updates the indicator's active dot accordingly.
///
/// ### Example Usage:
/// ```dart
/// Indicator(
///   controller: pageController,
///   count: 5,
/// );
/// ```
///
/// ### Lifecycle:
///
/// - The `initState` method adds a listener to the `PageController` to monitor page changes.
/// - The `dispose` method removes the listener when the widget is removed from the widget tree.
class Indicator extends StatefulWidget {
  final PageController controller; // Controller for tracking page changes
  final int count; // Total number of pages (and dots)

  /// Constructor for creating the `Indicator` widget.
  ///
  /// - `controller`: Controls the page navigation and provides the current page index.
  /// - `count`: Total number of pages in the `PageView`.
  const Indicator(this.controller, this.count, {super.key});

  @override
  State<Indicator> createState() => _IndicatorState();
}

class _IndicatorState extends State<Indicator> {
  @override
  void initState() {
    super.initState();
    widget.controller
        .addListener(_handleNaviagtionChanges); // Listen to page changes
  }

  @override
  void dispose() {
    widget.controller.removeListener(
        _handleNaviagtionChanges); // Remove listener when disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.f8, // Set height of the indicator
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: widget.count, // Number of dots
        itemBuilder: (context, index) {
          return _createIndicatorElement(
              index); // Create indicator for each page
        },
      ),
    );
  }

  /// Creates an individual dot for the page indicator.
  ///
  /// - `index`: The index of the dot relative to the number of pages.
  /// - Returns a `SizedBox` containing the dot.
  Widget _createIndicatorElement(int index) {
    return SizedBox(
      child: AnimatedContainer(
        margin: EdgeInsets.all(Sizes.f001),
        width: Sizes.f9,
        height: Sizes.f9,
        decoration: BoxDecoration(
          color: index == widget.controller.page
              ? const Color.fromARGB(255, 229, 233, 1) // Active page dot color
              : Colors.grey, // Inactive dot color
          shape: BoxShape.circle, // Circular dots
        ),
        duration: Duration(milliseconds: 200), // Animation duration
      ),
    );
  }

  /// Handles page navigation changes and updates the state to reflect the current page.
  void _handleNaviagtionChanges() {
    setState(() {});
  }
}
