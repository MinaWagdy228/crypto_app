import 'package:flutter/material.dart';
import '../../features/main_layout/presentation/MainLayoutScreen.dart';
import 'AppRoutes.dart';

import '../../features/splash/SplashScreen.dart';
import '../../features/onboarding/OnboardingContent.dart';
import '../../features/auth/AuthScreen.dart';
import '../../features/profile/ProfileScreen.dart';
import '../../features/settings/SettingsScreen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // You can also extract arguments from settings.arguments here if needed later

    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case AppRoutes.auth:
        return MaterialPageRoute(builder: (_) => const AuthScreen());

      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());

      case AppRoutes.mainLayout:
        return MaterialPageRoute(builder: (_) => const MainLayoutScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: const Center(child: Text('ERROR: Route not found!')),
        );
      },
    );
  }
}
