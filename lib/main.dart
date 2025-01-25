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
  late AnimationController _controller; // For the shapes animation
  late AnimationController _scaleController; // For the LandingContentPageView scale animation
  late Animation<double> _scaleAnimation; // Scale animation for the content
  late Animation<double> _opacityAnimation; // Opacity animation for the content
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();

    // Background shapes animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    // Scale animation for LandingContentPageView
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    // Define the scale animation, starting from 0.8 (small) to 1.0 (full size)
    _scaleAnimation = Tween<double>(
      begin: 0.8, // Start as small as 0
      end: 1.0,   // End at full size
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeOut, // Smooth easing curve
    ));

    // Define the opacity animation, starting from 0.0 (invisible) to 1.0 (fully visible)
    _opacityAnimation = Tween<double>(
      begin: 0.0, // Start with 0 opacity
      end: 1.0,   // End with full opacity
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeOut, // Smooth easing curve for opacity
    ));

    // Start the scale and opacity animation together
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

          // Blur filter overlay
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
            child: Container(
              color: Colors.black.withOpacity(0.2),
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
