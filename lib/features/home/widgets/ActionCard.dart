import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/AppColors.dart';
import '../../../../core/theme/AppStyles.dart';

class ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath; // Now accepts your PNG asset paths
  final VoidCallback onTap;

  const ActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0), // Space between stacked cards
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          // Subtle shadow to lift the card
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // 1. Left Image (Directly loading the 3D PNG)
            SvgPicture.asset(
              imagePath,
              width: 48,
              height: 48,
              fit: BoxFit.contain, // Ensures the image scales properly
            ),
            const SizedBox(width: 16),

            // 2. Middle Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppStyles.titleMedium(color: AppColors.black).copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppStyles.bodySmall(color: AppColors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // 3. Right Arrow
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: AppColors.lightBackground,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward,
                color: AppColors.grey,
                size: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}