import 'package:fdag/commons/colors/el_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IntroSlideOne extends StatefulWidget {
  const IntroSlideOne({super.key});

  @override
  State<IntroSlideOne> createState() => _IntroSlideOneState();
}

class _IntroSlideOneState extends State<IntroSlideOne> {
  @override
  void initState() {
    super.initState();
    // Hide ststua bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ElColor.darkBlue,
      body: Center(
        child: Text(
          'Slide 1: Welcome to the App!',
          style: TextStyle(fontSize: 32, color: ElColor.white),
        ),
      ),
    );
  }
}
