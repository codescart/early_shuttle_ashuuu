import 'dart:math';

import 'package:flutter/material.dart';



class myapppppp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dotted Circle Border'),
        ),
        body: Center(
          child: DottedCircleBorder(
            radius: 10.0, // Adjust the radius as needed
            borderWidth: 1, // Adjust the border width as needed
          ),
        ),
      ),
    );
  }
}

class DottedCircleBorder extends StatelessWidget {
  final double radius;
  final double borderWidth;

  DottedCircleBorder({required this.radius, required this.borderWidth});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(2 * (radius + borderWidth), 2 * (radius + borderWidth)),
      painter: DottedCirclePainter(radius, borderWidth),
    );
  }
}

class DottedCirclePainter extends CustomPainter {
  final double radius;
  final double borderWidth;

  DottedCirclePainter(this.radius, this.borderWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black // Border color
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..strokeCap = StrokeCap.round;

    final double spacing = 5.0; // Adjust the spacing between dots

    // Calculate the number of dots needed
    final double circumference = 2 * radius * 3.14159265359;
    final int numberOfDots = (circumference / spacing).round();

    // Draw the dotted border
    for (int i = 0; i < numberOfDots; i++) {
      double radians = (i / numberOfDots) * 3.14159265359 * 2;
      double x = radius + radius * cos(radians);
      double y = radius + radius * sin(radians);

      canvas.drawCircle(Offset(x, y), borderWidth / 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
