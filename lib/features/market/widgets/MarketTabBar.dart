import 'package:flutter/material.dart';

import '../../../../core/theme/AppColors.dart';
import '../../../../core/theme/AppStyles.dart';

class MarketTabBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabTapped;

  MarketTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTabTapped,
  });

  // The categories matching the Figma design
  final List<String> _tabs = ['Convert', 'Spot', 'Margin', 'Fiat'];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: AppColors.darkSurface.withOpacity(0.5), // Subtle dark background for the pill container
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_tabs.length, (index) {
          final isSelected = selectedIndex == index;

          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque, // Ensures the entire expanded area is clickable
              onTap: () => onTabTapped(index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  // Active tab gets a distinct background color; inactive remains transparent
                  color: isSelected ? AppColors.darkSurface : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  _tabs[index],
                  style: AppStyles.labelMedium(
                    // Highlight active text in white, dim inactive text to grey
                    color: isSelected ? AppColors.white : AppColors.grey,
                  ).copyWith(
                    // Make the active text slightly bolder for better contrast
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}