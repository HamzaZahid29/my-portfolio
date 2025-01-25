import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomPageIndicator extends StatelessWidget {
  PageController pageController;

  CustomPageIndicator({required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
