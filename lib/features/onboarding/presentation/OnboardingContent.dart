import 'package:crypto_app/core/routing/AppRoutes.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/AppAssets.dart';
import '../../../core/theme/AppColors.dart';
import '../../../core/theme/AppStyles.dart';
import '../../../core/widgets/PrimaryButton.dart';
import '../../auth/presentation/AuthScreen.dart';

// 1. A simple class to hold our page data
class OnboardingContent {
  final String image;
  final String title;
  final String description;

  OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // 2. The controller that handles the swiping logic
  late PageController _pageController;
  int _currentPageIndex = 0;

  // 3. Our content directly from your Figma designs
  final List<OnboardingContent> _contents = [
    OnboardingContent(
      image: AppAssets.onboard1,
      title: 'Trade anytime anywhere',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.',
    ),
    OnboardingContent(
      image: AppAssets.onboard2, // The astronaut taking off
      title: 'Transact fast and easy',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.',
    ),
    OnboardingContent(
      image: AppAssets.onboard3, // The astronaut with coffee
      title: 'Save and invest at the same time',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Logic for the "Next" button
  void _onNextPressed() {
    if (_currentPageIndex < _contents.length - 1) {
      // Animate to the next page
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.auth);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _contents.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // The Astronaut Image
                        Image.asset(
                          _contents[index].image,
                          height: 300,
                          // Adjust this based on how the assets look on screen
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 48),

                        // Title
                        Text(
                          _contents[index].title,
                          style: AppStyles.titleLarge(color: AppColors.white),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),

                        // Subtitle
                        Text(
                          _contents[index].description,
                          style: AppStyles.bodyMedium(color: AppColors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // The Bottom Section (Dots and Button)
            Padding(
              padding: const EdgeInsets.only(bottom: 48.0, left: 24, right: 24),
              child: Column(
                children: [
                  // The Page Indicator Dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _contents.length,
                      (index) => _buildDot(index: index),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Our Reusable Button!
                  PrimaryButton(
                    text: _currentPageIndex == _contents.length - 1
                        ? 'Get Started'
                        : 'Next',
                    width: 180,
                    onPressed: _onNextPressed,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // A helper method to build the little animated dots
  Widget _buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 8),
      height: 8,
      // If it's the active page, make it wide and green. Otherwise, small and grey.
      width: _currentPageIndex == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentPageIndex == index ? AppColors.primary : AppColors.grey,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
