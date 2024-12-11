import 'package:fdag/pages/top_navigation.dart';
import 'package:flutter/material.dart';

class ByLaws extends StatefulWidget {
  const ByLaws({super.key});

  @override
  State<ByLaws> createState() => _ByLawsState();
}

class _ByLawsState extends State<ByLaws> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("By-Laws"),
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
