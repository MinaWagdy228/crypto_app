import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/AppAssets.dart';
import '../../../../core/theme/AppColors.dart';
import '../../../../core/theme/AppStyles.dart';
import '../../../../core/routing/AppRoutes.dart';

class HomeMenuBottomSheet extends StatelessWidget {
  const HomeMenuBottomSheet({super.key});

  // A static helper method to easily show this bottom sheet from anywhere
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows it to be full screen
      backgroundColor: AppColors.darkBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => const HomeMenuBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // We wrap the content in a container that takes up 90% of screen height
      child: FractionallySizedBox(
        heightFactor: 0.95,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Header
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: AppColors.grey),
                  ),
                  Text('Menu', style: AppStyles.titleLarge(color: AppColors.white)),
                  const Icon(Icons.more_vert, color: AppColors.grey),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 2. Profile Summary Card
                    _buildProfileCard(context),
                    const SizedBox(height: 32),

                    // 3. Categories (Reusing a helper method to draw the grids)
                    _buildCategorySection('Common', [
                      _MenuItem('Transfer', AppAssets.menuBuy), // Assuming placeholder icon
                      _MenuItem('Deposit', AppAssets.menuDeposit),
                      _MenuItem('Orders', AppAssets.menuMore), // Placeholder
                      _MenuItem('Referral', AppAssets.menuReferral),
                    ]),

                    _buildCategorySection('Trade', [
                      _MenuItem('Convert', AppAssets.menuBuy),
                      _MenuItem('Spot', AppAssets.menuScan),
                      _MenuItem('Margin', AppAssets.menuMargin),
                      _MenuItem('Grid Trading', AppAssets.menuGrid),
                      _MenuItem('Liquid Swap', AppAssets.menuLiquid),
                    ]),

                    _buildCategorySection('Finance', [
                      _MenuItem('Savings', AppAssets.menuSavings),
                      _MenuItem('Staking', AppAssets.menuBuy),
                      _MenuItem('Pay', AppAssets.menuBuy),
                      _MenuItem('Crypto Loans', AppAssets.menuBuy),
                      _MenuItem('Pool', AppAssets.menuLiquid),
                      _MenuItem('ETH 2.0', AppAssets.menuBuy),
                      _MenuItem('Launchpad', AppAssets.menuLaunchpad),
                    ]),

                    const SizedBox(height: 48), // Bottom padding
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Row(
      children: [
        // Avatar
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary, width: 2), // Figma shows a green border here
            image: const DecorationImage(
              image: AssetImage(AppAssets.avatarProfile),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 16),
        // User Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('User 1234', style: AppStyles.titleMedium(color: AppColors.white)),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text('ID: 1234567890', style: AppStyles.bodySmall(color: AppColors.grey)),
                  const SizedBox(width: 4),
                  const Icon(Icons.copy, color: AppColors.secondary, size: 12),
                ],
              )
            ],
          ),
        ),
        // Edit Profile Button
        GestureDetector(
          onTap: () {
            Navigator.pop(context); // Close menu first
            Navigator.pushNamed(context, AppRoutes.profile); // Route to Profile Screen
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primary25, // Assuming this is the translucent green
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text('Edit Profile', style: AppStyles.labelMedium(color: AppColors.primary)),
          ),
        )
      ],
    );
  }

  Widget _buildCategorySection(String title, List<_MenuItem> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppStyles.titleMedium(color: AppColors.white)),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 24,
              crossAxisSpacing: 8,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final item = items[index];
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    item.iconPath,
                    colorFilter: const ColorFilter.mode(AppColors.secondary, BlendMode.srcIn),
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.title,
                    style: AppStyles.labelMedium(color: AppColors.lightGrey).copyWith(fontSize: 11),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

// Private helper model for this file
class _MenuItem {
  final String title;
  final String iconPath;
  _MenuItem(this.title, this.iconPath);
}