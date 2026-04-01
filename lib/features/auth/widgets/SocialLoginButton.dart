import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/theme/AppColors.dart';
import '../../../core/theme/AppStyles.dart';

class SocialLoginButton extends StatelessWidget {
  final String text;
  final String iconPath;
  final VoidCallback onPressed;

  const SocialLoginButton({
    super.key,
    required this.text,
    required this.iconPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54, // Matching the height of your primary text fields and buttons
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.white, // White background per Figma
          foregroundColor: AppColors.darkSurface, // The splash/ripple color when tapped
          elevation: 0, // Flat modern design
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          // Adding some padding so the content doesn't hit the edges on smaller screens
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // The Social Icon
            SvgPicture.asset(
              iconPath,
              height: 24,
              width: 24,
            ),
            const SizedBox(width: 12), // Space between icon and text

            // The Text
            Text(
              text,
              style: AppStyles.button().copyWith(
                fontSize: 16, // Slightly smaller text than the main green button
              ),
            ),
          ],
        ),
      ),
    );
  }
}