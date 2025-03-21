import 'package:flutter/material.dart';

class HeatWordMap extends StatefulWidget {
  const HeatWordMap({super.key});

  @override
  State<HeatWordMap> createState() => _HeatWordMapState();
}

class _HeatWordMapState extends State<HeatWordMap> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellowAccent,
      height: 1000,
      width: 1000,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(1000, 1000),
            painter: LinePainter(
              start: Offset(
                MediaQuery.of(context).size.width.toDouble() / 7,
                MediaQuery.of(context).size.height.toDouble() / 7,
              ),
              end: Offset(
                MediaQuery.of(context).size.width.toDouble() / 4,
                MediaQuery.of(context).size.height.toDouble() / 4,
              ),
            ),
          ),

          Positioned(
              top: MediaQuery.of(context).size.height.toDouble() / 4,
              left: MediaQuery.of(context).size.width.toDouble() / 4,
              child: Text(
                'banana',
              ))
        ],
      ),
    );
  }
}

// GPT CODE

class LinePainter extends CustomPainter {
  final Offset start;
  final Offset end;
  final Paint _paint;

  LinePainter({required this.start, required this.end})
      : _paint = Paint()
          ..color = Colors.blue
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(start, end, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Pode ser otimizado para repaint apenas quando necessário
  }
}
