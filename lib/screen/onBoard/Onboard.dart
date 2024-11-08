import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulvoyage/component/constatnt.dart';
import 'package:soulvoyage/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soulvoyage/screen/dashboard/Dashboard.dart';
import 'package:soulvoyage/screen/onBoard/ScreenOne.dart';
import 'package:soulvoyage/screen/onBoard/ScreenThree.dart';
import 'package:soulvoyage/screen/onBoard/ScreenTwo.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  String? token;
  bool isTokenLoading = true;
  @override
  void initState() {
    super.initState();
    checkToken(); // Call checkToken in initState instead of using FutureBuilder
  }

  // Function to check if the token is available in SharedPreferences
  Future<void> checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('jwttoken');

    if (token != null && token!.isNotEmpty) {
      // Navigate to Dashboard if token is available
      Get.offAll(() => const Dashboard());
    } else {
      setState(() {
        isTokenLoading = false; // Set to false once token check completes
      });
    }
  }

  final List<Widget> _titles = [
    const Screenone(),
    const ScreenTwo(),
    const ScreenThree(),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return isTokenLoading
        ? const Scaffold(
          appBar: null,
            body: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            appBar: null,
            body:  Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _titles.length,
                      onPageChanged: (int index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Image.asset("assets/onboarding_$index.png",
                              //     height: 200), // Add your images
                              const SizedBox(height: 20),
                              _titles[index],
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.12),
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          backgroundColor:
                              kButton, // Set the button color using hex value
                          foregroundColor: kTextColor, // Text color
                          elevation: 5,
                          shadowColor: Colors.black.withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(15), // Border radius of 5
                          ),
                        ),
                        onPressed: () {
                          if (_currentIndex < _titles.length - 1) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            Get.offAll(() => const LoginScreenWithBackExit());
                          }
                        },
                        child: Text(
                          _currentIndex == _titles.length - 1
                              ? "Create Account"
                              : _currentIndex == _titles.length - 2
                                  ? "Continue"
                                  : "Let’s get Started",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _titles.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        height: 8,
                        width: _currentIndex == index ? 20 : 8,
                        decoration: BoxDecoration(
                          color: _currentIndex == index
                              ? Colors.deepPurple
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            
          );
  }
}
