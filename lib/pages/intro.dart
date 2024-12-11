import 'package:fdag/commons/buttons/btn_back.dart';
import 'package:fdag/commons/buttons/btn_forward.dart';
import 'package:fdag/commons/buttons/btn_home.dart';
import 'package:fdag/commons/buttons/indicator.dart';
import 'package:fdag/pages/intro/intro_slide_one.dart';
import 'package:fdag/pages/intro/intro_slide_three.dart';
import 'package:fdag/pages/intro/intro_slide_two.dart';
import 'package:fdag/utils/logging/logger.dart';
import 'package:flutter/material.dart';

/// The `Intro` class displays an introductory page with multiple slides.
///
/// This class extends `StatefulWidget` and manages the state of the intro
/// slides, including navigation between them. It utilizes a `PageController`
/// to control the `PageView` widget, allowing users to swipe through
/// the slides.
///
/// The class maintains the current page index and whether the last slide
/// has been reached. It also updates the UI based on the user's navigation
/// actions. If the last slide is reached, the "Home" button is displayed;
/// otherwise, the "Next" button is shown.
///
/// The `Intro` class contains the following key components:
/// - `PageView` to display the introductory slides.
/// - An `Indicator` widget to show the current slide progress.
/// - Navigation buttons to move between slides and navigate to the home screen.
class Intro extends StatefulWidget {
  final VoidCallback onIntroComplete;

  const Intro({super.key, required this.onIntroComplete});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  final PageController _pageController = PageController();
  int totalPages = 3;
  int _currentPage = 0;
  bool _isEnded = false;

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();

        if (_currentPage == totalPages - 1) {
          _isEnded = true;
          Logger.logLevel = 'INFO';
          Logger.info("App Log: End of intro slide");
        } else {
          _isEnded = false;
        }
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              children: [
                IntroSlideOne(),
                IntroSlideTwo(),
                IntroSlideThree(),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Indicator(_pageController, totalPages),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: btnBack(context, _pageController),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _isEnded
                              ? btnHome(context,
                                  widget.onIntroComplete) // Trigger callback
                              : btnForward(context, _pageController),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
