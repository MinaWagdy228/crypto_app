import 'package:flutter/material.dart';

import 'AppColors.dart';

class AppStyles {
  AppStyles._();

  static const String fontFamily = 'NeueMontreal';

  static TextStyle _base({
    required double size,
    FontWeight weight = FontWeight.w400,
    Color color = AppColors.white,
    double? height,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  // Display
  static TextStyle displayLarge({Color color = AppColors.white}) =>
      _base(size: 36, weight: FontWeight.w700, color: color, height: 1.2);
  static TextStyle displayMedium({Color color = AppColors.white}) =>
      _base(size: 32, weight: FontWeight.w700, color: color, height: 1.2);

  // Titles
  static TextStyle titleLarge({Color color = AppColors.white}) =>
      _base(size: 24, weight: FontWeight.w700, color: color, height: 1.25);
  static TextStyle titleMedium({Color color = AppColors.white}) =>
      _base(size: 20, weight: FontWeight.w600, color: color, height: 1.3);
  static TextStyle titleSmall({Color color = AppColors.white}) =>
      _base(size: 18, weight: FontWeight.w500, color: color, height: 1.3);

  // Body
  static TextStyle bodyLarge({Color color = AppColors.white}) =>
      _base(size: 16, weight: FontWeight.w500, color: color, height: 1.4);
  static TextStyle bodyMedium({Color color = AppColors.white}) =>
      _base(size: 14, weight: FontWeight.w400, color: color, height: 1.4);
  static TextStyle bodySmall({Color color = AppColors.lightGrey}) =>
      _base(size: 12, weight: FontWeight.w400, color: color, height: 1.4);

  // Labels & buttons
  static TextStyle labelLarge({Color color = AppColors.white}) =>
      _base(size: 14, weight: FontWeight.w600, color: color, letterSpacing: 0.1);
  static TextStyle labelMedium({Color color = AppColors.white}) =>
      _base(size: 12, weight: FontWeight.w500, color: color, letterSpacing: 0.2);
  static TextStyle button({Color color = AppColors.black}) =>
      _base(size: 16, weight: FontWeight.w700, color: color, height: 1.2);

  // Helper semantic styles
  static TextStyle error({double size = 12}) =>
      _base(size: size, weight: FontWeight.w500, color: AppColors.error);
  static TextStyle success({double size = 12}) =>
      _base(size: size, weight: FontWeight.w500, color: AppColors.success);
}

