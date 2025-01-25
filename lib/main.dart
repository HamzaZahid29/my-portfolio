import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() => runApp(BlurredShapesApp());

class BlurredShapesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlurredShapesHome(),
    );
  }
}

class BlurredShapesHome extends StatefulWidget {
  @override
  _BlurredShapesHomeState createState() => _BlurredShapesHomeState();
}

class _BlurredShapesHomeState extends State<BlurredShapesHome>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Animated shapes in the background
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: BlurredShapesPainter(_controller.value),
                child: Container(),
              );
            },
          ),

          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: SmoothPageIndicator(
                    controller: pageController, // PageController
                    count: 4,
                    axisDirection: Axis.vertical,
                    effect: WormEffect(
                        dotColor: Colors.white.withOpacity(0.5),
                        activeDotColor: Colors.black.withOpacity(0.8),
                        spacing: 3,
                        dotHeight: 8,
                        dotWidth: 8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BlurredShapesPainter extends CustomPainter {
  final double progress;

  BlurredShapesPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Randomized positions, colors, and sizes for shapes
    final shapes = [
      _createShape(size, Colors.pink, 0.2, 0.3, 150),
      _createShape(size, Colors.blue, 0.7, 0.6, 200),
      _createShape(size, Colors.green, 0.5, 0.8, 180),
      _createShape(size, Colors.orange, 0.3, 0.4, 120),
      _createShape(size, Colors.purple, 0.6, 0.2, 160),
    ];

    for (var shape in shapes) {
      paint.color = shape.color.withOpacity(0.8);
      canvas.drawCircle(
        Offset(
          shape.x + 100 * sin(progress * 2 * pi + shape.x),
          // Enhanced movement along X
          shape.y +
              100 *
                  cos(progress * 2 * pi + shape.y), // Enhanced movement along Y
        ),
        shape.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  _Shape _createShape(Size size, Color color, double xFactor, double yFactor,
      double sizeFactor) {
    return _Shape(
      x: size.width * xFactor,
      y: size.height * yFactor,
      color: color,
      size: sizeFactor,
    );
  }
}

class _Shape {
  final double x;
  final double y;
  final Color color;
  final double size;

  _Shape({
    required this.x,
    required this.y,
    required this.color,
    required this.size,
  });
}
