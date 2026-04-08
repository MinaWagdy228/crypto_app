import 'package:crypto_app/features/home/HomeScreen.dart';
import 'package:crypto_app/features/main_layout/widgets/CustomBottomNavBar.dart';
import 'package:crypto_app/features/market/MarketScreen.dart';
import 'package:crypto_app/features/settings/SettingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/AppColors.dart';
import '../wallet/WalletScreen.dart';
import '../wallet/cubit/WalletCubit.dart';

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
    const MarketScreen(),
    const Center(
      child: Text('Activity', style: TextStyle(color: Colors.white)),
    ),
    const WalletScreen(),
    const SettingsScreen(),
  ];

  // 3. Simple state update method
  void _onTabTapped(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
    }
    if (index == 3) {
      context.read<WalletCubit>().loadFavorites();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Stack(
        children: [
          // Preserves the state of the screens as you switch
          IndexedStack(index: _currentIndex, children: _screens),

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
