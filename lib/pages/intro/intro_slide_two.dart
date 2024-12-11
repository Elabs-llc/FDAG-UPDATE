import 'package:fdag/commons/colors/el_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IntroSlideTwo extends StatefulWidget {
  const IntroSlideTwo({super.key});

  @override
  State<IntroSlideTwo> createState() => _IntroSlideTwoState();
}

class _IntroSlideTwoState extends State<IntroSlideTwo> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ElColor.gold,
      body: Center(
        child: Text(
          'Slide 2: Welcome to the App!',
          style: TextStyle(fontSize: 32, color: ElColor.white),
        ),
      ),
    );
  }
}
