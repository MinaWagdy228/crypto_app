import 'package:flutter/material.dart';

import '../theme/AppColors.dart';
import '../theme/AppStyles.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double height;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height = 54.0, // Default height based on your Figma properties
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width, // If left null, the button will size itself flexibly
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary, // Your brand's primary color
          elevation: 0, // Keeps the modern, flat design from your mockups
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0), // The pill-like corner radius
          ),
        ),
        child: Text(
          text,
          style: AppStyles.button(color: AppColors.white), // White text for contrast on the primary color
        ),
      ),
    );
  }
}