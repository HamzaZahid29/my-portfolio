import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_portfolio/pages/landing_content_page_view.dart';

import 'core/widgets/custom_page_indicator.dart';

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
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  PageController pageController = PageController(
    initialPage: 1
  );

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeOut,
    ));
    _scaleController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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

          // Blur filter overlay
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
            child: Container(
              color: Colors.black.withOpacity(0.1),
            ),
          ),

          // Page indicator
          Align(
            alignment: Alignment.centerRight,
            child: CustomPageIndicator(
              pageController: pageController,
            ),
          ),

          // Scale and fade-in LandingContentPageView (appears from the center)
          Center(
            child: FadeTransition(
              opacity: _opacityAnimation, // Apply opacity transition
              child: ScaleTransition(
                scale: _scaleAnimation, // Apply scale transition
                child: LandingContentPageView(
                  pageController: pageController,
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
