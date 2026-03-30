import 'package:flutter/material.dart';

import '../../../core/constants/AppAssets.dart';
import '../../../core/theme/AppColors.dart';
import '../../onboarding/presentation/OnboardingContent.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  // Simulating the splash screen duration and MVVM routing logic
  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(milliseconds: 2500));

    if (!mounted) return;

    // pushReplacement ensures the user can't swipe back to the splash screen!
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Stack(
        children: [
          // LAYER 1: The Constellation Background (without_logo.png)
          Positioned.fill(
            child: Image.asset(
              AppAssets.withoutLogo,
              fit: BoxFit.cover, // Ensures it stretches beautifully on any device
            ),
          ),

          // LAYER 2: Centered Logo and Text
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.logo,
                  width: 180, // Sized based on your Figma proportions
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),

          // LAYER 3: The Bottom Green Gradient Overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 80, // Exact height from your Figma properties
            child: Container(
              decoration:  BoxDecoration(
                gradient: AppColors.splashGradient,
              ),
            ),
          ),
        ],
      ),
    );
  }
}