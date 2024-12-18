import 'package:flutter/material.dart';

class PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    for (var i = 0; i < size.width; i += 20) {
      canvas.drawLine(
        Offset(i.toDouble(), 0),
        Offset(i.toDouble() + 10, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
