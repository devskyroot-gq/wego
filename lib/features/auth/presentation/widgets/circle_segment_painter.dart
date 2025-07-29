import 'package:flutter/material.dart';

class CircleSegmentPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 10.0;
    final rect = Offset.zero & size;
    final center = Offset(size.width/2, size.height/2);
    final radius = size.width/2 - strokeWidth/2;

    final paintRed = Paint()
                    ..color = Colors.red
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = strokeWidth;
    
    final paintGreen = Paint()
                    ..color = Colors.green
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = strokeWidth;
    //arc segments
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), 3.14, 1.0, false, paintRed);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), 4.14, 1.0, false, paintGreen);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}