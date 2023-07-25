import 'package:flutter/material.dart';

class NumbersPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    
    var paint = Paint()
      ..color = const Color(0xffb5c2d2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    var path = Path()
      ..moveTo(size.width * 0.5, size.height * 0.01)
      ..lineTo(size.width * 0.5, size.height * 0.06)
      ..moveTo(size.width * 0.5, size.height * 0.99)
      ..lineTo(size.width * 0.5, size.height * 0.94)
      ..moveTo(size.width * 0.01, size.height * 0.5)
      ..lineTo(size.width * 0.06, size.height * 0.5)
      ..moveTo(size.width * 0.99, size.height * 0.5)
      ..lineTo(size.width * 0.94, size.height * 0.5);
    
    canvas.drawPath(path, paint);
    
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}