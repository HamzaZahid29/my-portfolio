import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_portfolio/core/constants/asset_paths.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vector_graphics/vector_graphics.dart';

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
                          color: Colors.black,
                          letterSpacing: 4,
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
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () async {
                              if (!await launchUrl(Uri.parse(
                                  'https://www.linkedin.com/in/hamza-zahid-85a101289'))) {
                                throw Exception(
                                    'Could not launch https://www.linkedin.com/in/hamza-zahid-85a101289');
                              }
                            },
                            icon: SvgPicture.asset(
                              AssetPaths.linkedinLogo,
                              height: 30,
                              width: 30,
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        IconButton(
                            onPressed: () async {
                              if (!await launchUrl(Uri.parse(
                                  'https://github.com/HamzaZahid29'))) {
                                throw Exception(
                                    'Could not launch https://github.com/HamzaZahid29');
                              }
                            },
                            icon: SvgPicture.asset(
                              AssetPaths.githubLogo,
                              height: 30,
                              width: 30,
                            )),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 38, horizontal: 18),
                child: Column(
                  children: [
                    Text(
                      'My Contributions',
                      style: TextStyle(color: Colors.black, fontFamily: 'as', fontWeight: FontWeight.w900, fontSize: 30),
                    ),
                    Container(

                    )
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
            ],
          ),
        ),
      ],
    ));
  }
}
