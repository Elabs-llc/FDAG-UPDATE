import 'package:fdag/commons/colors/el_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IntroSlideThree extends StatefulWidget {
  const IntroSlideThree({super.key});

  @override
  State<IntroSlideThree> createState() => _IntroSlideThreeState();
}

class _IntroSlideThreeState extends State<IntroSlideThree> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  }

  @override
  void dispose() {
    super.dispose();
    // show status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ElColor.red,
      body: Center(
        child: Text(
          'Slide 1: Welcome to the App!',
          style: TextStyle(fontSize: 32, color: ElColor.white),
        ),
      ),
    );
  }
}
