import 'package:fdag/pages/top_navigation.dart';
import 'package:flutter/material.dart';

class Mv extends StatefulWidget {
  const Mv({super.key});

  @override
  State<Mv> createState() => _MvState();
}

class _MvState extends State<Mv> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mission & Vision"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TopNavigation(),
        ),
      ),
    );
  }
}
