import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todoapp/theme/appcolor.dart';
import 'package:todoapp/slider%20and%20start/start_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark theme background
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                isLastPage = (index == 2);
              });
            },
            children: [
              buildPage(
                imagePath: "assets/svg/Intro1.svg",
                title: "Manage your tasks",
                description:
                    "You can easily manage all of your daily tasks in DoMe for free",
              ),
              buildPage(
                imagePath: "assets/svg/Intro2.svg",
                title: "Create daily routine",
                description:
                    "In Uptodo you can create your personalized routine to stay productive",
              ),
              buildPage(
                imagePath: "assets/svg/Intro3.svg",
                title: "Organize your tasks",
                description:
                    "You can organize your daily tasks by adding them into separate categories",
              ),
            ],
          ),

          // Skip Button
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: () => _controller.jumpToPage(2),
              child: Text("SKIP", style: TextStyle(color: Colors.white)),
            ),
          ),

          // Page Indicator
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: WormEffect(activeDotColor: Appcolor.primary),
              ),
            ),
          ),

          // Navigation Buttons
          Positioned(
            bottom: 30,
            left: 20,
            child: isLastPage
                ? SizedBox() // Hide back button on last page
                : TextButton(
                    onPressed: () {
                      _controller.previousPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    child: Text("BACK", style: TextStyle(color: Colors.white)),
                  ),
          ),

          Positioned(
            bottom: 30,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                if (isLastPage) {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>StartScreen()));
                } else {
                  _controller.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolor.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(isLastPage ? "GET STARTED" : "NEXT"),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage(
      {required String imagePath,
      required String title,
      required String description}) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(imagePath),
          SizedBox(height: 30),
          Text(
            title,
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
