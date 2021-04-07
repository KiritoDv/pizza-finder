import 'package:flutter/material.dart';

class PriceRange extends StatelessWidget {

  final int length;

  PriceRange({this.length = 3});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(      
      painter: PriceRangeViewer(length: this.length),
    );
  }
}

class PriceRangeViewer extends CustomPainter {

  final int length;

  PriceRangeViewer({this.length = 3});

  int max(number, limit) => number >= limit ? limit : number;

  @override
  void paint(Canvas canvas, Size size) {    
    double w = 2;
    double h = 3;
    double p = 1.5;    
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), Paint()..color = Colors.black);
    for(double l = 0; l < 3; l++){
      canvas.drawRect(Rect.fromLTWH((w + p) * l, size.height - (h + l * 3) - 5, w, h + l * 3), Paint()..color = l < this.length ? Colors.white : Colors.grey.withOpacity(0.5));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}