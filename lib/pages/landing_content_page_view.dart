import 'package:flutter/material.dart';

class LandingContentPageView extends StatelessWidget {
  PageController pageController;

  LandingContentPageView({required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
      children: [
        Expanded(
          child: PageView(
            controller: pageController,
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hamza Zahid',
                      style: TextStyle(
                          fontFamily: 'as',
                          color: Colors.white,
                          fontSize: 42,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Flutter Engineer',
                      style: TextStyle(
                          fontFamily: 'as',
                          letterSpacing: 10,
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w100),
                    ),
                  ],
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                    'Under Development',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                    'Under Development',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                    'Under Development',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
