import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColors.dart';
import '../../../../../core/theme/AppStyles.dart';
import '../../../../../core/widgets/CustomTextField.dart';

class ProfileEditableField extends StatelessWidget {
  final String label;
  final String displayValue;
  final bool isEditMode;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;

  const ProfileEditableField({
    super.key,
    required this.label,
    required this.displayValue,
    required this.isEditMode,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    if (isEditMode) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppStyles.bodySmall(color: AppColors.grey),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: controller,
              hintText: 'Enter $label',
              isPassword: isPassword,
              keyboardType: keyboardType,
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: AppStyles.bodyMedium(color: AppColors.grey),
            ),
            Text(
              isPassword ? '••••••••••' : displayValue,
              style: AppStyles.bodyMedium(color: AppColors.white),
            ),
          ],
        ),
      );
    }
  }
}