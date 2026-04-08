import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/AppAssets.dart';
import '../../core/routing/AppRoutes.dart';
import '../../core/theme/AppColors.dart';
import '../auth/cubit/UserCubit.dart';
import '../auth/cubit/UserStates.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Fire the Cubit event the moment the screen loads
    context.read<UserCubit>().checkAuthStatus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserStates>(
      listener: (context, state) {
        if (state is UserAuthenticatedState) {
          Navigator.pushReplacementNamed(context, AppRoutes.mainLayout);
        } else if (state is UserUnauthenticatedState) {
          Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.darkBackground,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(AppAssets.withoutLogo, fit: BoxFit.cover),
            ),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppAssets.logo, width: 180),
                  const SizedBox(height: 16),
                ],
              ),
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 80,
              child: Container(
                decoration: BoxDecoration(gradient: AppColors.splashGradient),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
