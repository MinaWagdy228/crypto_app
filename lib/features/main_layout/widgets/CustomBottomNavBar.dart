import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/AppAssets.dart';
import '../../../core/theme/AppColors.dart';
import '../../../core/theme/AppStyles.dart';

class BottomNavItem {
  final String label;
  final String iconPath;

  BottomNavItem({required this.label, required this.iconPath});
}

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final List<BottomNavItem> _navItems = [
    BottomNavItem(label: 'Home', iconPath: AppAssets.navHome),
    BottomNavItem(label: 'Markets', iconPath: AppAssets.navMarket),
    BottomNavItem(label: 'Activity', iconPath: AppAssets.navActivity),
    BottomNavItem(label: 'Wallets', iconPath: AppAssets.navWallet),
    BottomNavItem(label: 'Settings', iconPath: AppAssets.navTrades),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(_navItems.length, (index) {
          final item = _navItems[index];
          final isSelected = currentIndex == index;

          return GestureDetector(
            behavior: HitTestBehavior.opaque, // Ensures the whole column is clickable
            onTap: () => onTap(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  item.iconPath,
                  colorFilter: ColorFilter.mode(
                    isSelected ? AppColors.primary : AppColors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.label,
                  style: AppStyles.labelMedium(
                    color: isSelected ? AppColors.primary : AppColors.grey,
                  ).copyWith(fontSize: 10),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}