import 'package:flutter/material.dart';

import '../../../../../core/constants/AppAssets.dart';
import '../../../../../core/theme/AppColors.dart';

class ProfileAvatar extends StatelessWidget {
  final bool isEditMode;
  final VoidCallback? onEditAvatarTapped;

  const ProfileAvatar({
    super.key,
    this.isEditMode = false,
    this.onEditAvatarTapped,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Only allow tapping if we are in edit mode
      onTap: isEditMode ? onEditAvatarTapped : null,
      child: Stack(
        children: [
          // 1. Main Avatar Image
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // Adding a subtle border to separate it from the background
              border: Border.all(color: AppColors.darkSurface, width: 2),
              image: const DecorationImage(
                image: AssetImage(AppAssets.avatarProfile),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 2. Camera Overlay (Visible ONLY in Edit Mode)
          if (isEditMode)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.darkSurface, // Matches Figma's dark icon background
                  shape: BoxShape.circle,
                  // The border creates a cutout effect against the avatar
                  border: Border.all(color: AppColors.darkBackground, width: 3),
                ),
                child: const Icon(
                  Icons.camera_alt_outlined,
                  color: AppColors.white,
                  size: 18,
                ),
              ),
            ),
        ],
      ),
    );
  }
}