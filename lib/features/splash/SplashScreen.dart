import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/AppAssets.dart';
import '../../core/routing/AppRoutes.dart';
import '../../core/theme/AppColors.dart';
// You might not need this import if you aren't using the OnboardingContent widget directly here
// import '../onboarding/OnboardingContent.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkSessionAndNavigate();
  }

  // Combines your splash duration with our MVVM/Session routing logic
  Future<void> _checkSessionAndNavigate() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('IS_LOGGED_IN') ?? false;

    await Future.delayed(const Duration(milliseconds: 2500));

    if (!mounted) return;

    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, AppRoutes.mainLayout);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Stack(
        children: [
          // LAYER 1: The Constellation Background
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
              decoration: BoxDecoration(
                gradient: AppColors.splashGradient,
              ),
            ),
          ),
        ],
      ),
    );
  }
}