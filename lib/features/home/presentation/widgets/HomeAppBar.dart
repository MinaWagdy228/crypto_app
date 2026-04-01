import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/AppAssets.dart';
import '../../../../core/theme/AppColors.dart';

class HomeAppBar extends StatelessWidget {
  final VoidCallback? onAvatarTapped;
  final VoidCallback? onSearchTapped;
  final VoidCallback? onScanTapped;
  final VoidCallback? onNotifTapped;

  const HomeAppBar({
    super.key,
    this.onAvatarTapped,
    this.onSearchTapped,
    this.onScanTapped,
    this.onNotifTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 1. User Avatar (Scaled down for the App Bar)
          GestureDetector(
            onTap: onAvatarTapped,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.darkSurface, width: 2),
                image: const DecorationImage(
                  image: AssetImage(AppAssets.avatarProfile),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // 2. Action Icons
          Row(
            children: [
              _buildIconButton(AppAssets.menuSearch, onSearchTapped),
              const SizedBox(width: 20),
              _buildIconButton(AppAssets.menuScan, onScanTapped),
              const SizedBox(width: 20),
              _buildIconButton(AppAssets.menuNotif, onNotifTapped),
            ],
          ),
        ],
      ),
    );
  }

  // Helper method to keep icon buttons consistent
  Widget _buildIconButton(String iconPath, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        iconPath,
        colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
      ),
    );
  }
}