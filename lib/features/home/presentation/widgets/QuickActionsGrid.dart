import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/AppAssets.dart';
import '../../../../core/theme/AppColors.dart';
import '../../../../core/theme/AppStyles.dart';

// Simple model to hold action data cleanly
class QuickActionItem {
  final String title;
  final String iconPath;
  final bool isMore; // Flags the "More" button to trigger specific logic

  QuickActionItem({required this.title, required this.iconPath, this.isMore = false});
}

class QuickActionsGrid extends StatelessWidget {
  final VoidCallback onMoreTapped;

  QuickActionsGrid({super.key, required this.onMoreTapped});

  // The 8 actions defined in the Figma design
  final List<QuickActionItem> _actions = [
    QuickActionItem(title: 'Deposit', iconPath: AppAssets.menuDeposit),
    QuickActionItem(title: 'Referral', iconPath: AppAssets.menuReferral),
    QuickActionItem(title: 'Grid Trading', iconPath: AppAssets.menuGrid),
    QuickActionItem(title: 'Margin', iconPath: AppAssets.menuMargin),
    QuickActionItem(title: 'Launchpad', iconPath: AppAssets.menuLaunchpad),
    QuickActionItem(title: 'Savings', iconPath: AppAssets.menuSavings),
    QuickActionItem(title: 'Liquid Swap', iconPath: AppAssets.menuLiquid),
    QuickActionItem(title: 'More', iconPath: AppAssets.menuMore, isMore: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      // GridView is perfect here to automatically handle the 4-column layout
      child: GridView.builder(
        shrinkWrap: true, // Required because it's inside a SingleChildScrollView
        physics: const NeverScrollableScrollPhysics(), // Disables inner scrolling
        itemCount: _actions.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 24,
          crossAxisSpacing: 8,
          childAspectRatio: 0.8, // Adjusts the height/width ratio of the grid items
        ),
        itemBuilder: (context, index) {
          final item = _actions[index];
          return GestureDetector(
            onTap: () {
              if (item.isMore) {
                onMoreTapped();
              } else {
                print('${item.title} tapped');
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  item.iconPath,
                  colorFilter: const ColorFilter.mode(AppColors.secondary, BlendMode.srcIn)
                ),
                const SizedBox(height: 8),
                Text(
                  item.title,
                  style: AppStyles.labelMedium(color: AppColors.lightGrey).copyWith(fontSize: 11),
                  textAlign: TextAlign.center,
                  maxLines: 1, // Prevents text from breaking layout if it gets too long
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}