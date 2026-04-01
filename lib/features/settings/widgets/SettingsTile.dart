import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/AppColors.dart';
import '../../../core/theme/AppStyles.dart';

class SettingsTile extends StatelessWidget {
  final String iconPath;
  final String title;
  final String?
  trailingText; // Optional: Some tiles might not have a value text
  final VoidCallback onTap;

  const SettingsTile({
    super.key,
    required this.iconPath,
    required this.title,
    this.trailingText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12), // Keeps the ripple effect clean
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Row(
          children: [
            // 1. The Icon (Tinted slightly green based on your design)
            Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: AppColors.darkSurface, // Uses your solid surface color!
                    shape: BoxShape.circle,
                  ),
              child: Center(
                child: SvgPicture.asset(
                  iconPath,
                  height: 24,
                  width: 24,
                ),
              ),
            ),
            const SizedBox(width: 16),

            // 2. The Title
            Text(
              title,
              style: AppStyles.bodyMedium(
                color: AppColors.white,
              ).copyWith(fontSize: 16),
            ),

            const Spacer(), // Pushes everything else to the far right
            // 3. Optional Trailing Value (e.g., "English", "USD")
            if (trailingText != null) ...[
              Text(
                trailingText!,
                style: AppStyles.bodyMedium(color: AppColors.grey),
              ),
              const SizedBox(width: 8),
            ],

            // 4. The Right Arrow
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.grey,
              size: 16, // Kept small to match the subtle design
            ),
          ],
        ),
      ),
    );
  }
}
