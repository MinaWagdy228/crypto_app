import 'package:crypto_app/features/home/presentation/HomeScreen.dart';
import 'package:crypto_app/features/main_layout/presentation/widgets/CustomBottomNavBar.dart';
import 'package:crypto_app/features/settings/presentation/SettingsScreen.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/AppColors.dart';


class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  // 1. Local state for the selected tab
  int _currentIndex = 0;

  // 2. The screens corresponding to the tabs
  final List<Widget> _screens = [
    const HomeScreen(),
    const Center(child: Text('Markets', style: TextStyle(color: Colors.white))),
    const Center(child: Text('Activity', style: TextStyle(color: Colors.white))),
    const Center(child: Text('Wallet', style: TextStyle(color: Colors.white))),
    const SettingsScreen(),
  ];

  // 3. Simple state update method
  void _onTabTapped(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Stack(
        children: [
          // Preserves the state of the screens as you switch
          IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),

          // The floating Bottom Navigation Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: CustomBottomNavBar(
                currentIndex: _currentIndex,
                onTap: _onTabTapped,
              ),
            ),
          ),
        ],
      ),
    );
  }
}