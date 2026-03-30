import 'package:flutter/material.dart';
import '../theme/AppColors.dart';
import '../theme/AppStyles.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  // We keep the visibility state local to this widget
  // because it's purely UI logic, not business logic for the ViewModel!
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    // Initialize the obscure state based on whether it's a password field
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54, // Matching the height of your primary button
      decoration: BoxDecoration(
        color: AppColors.darkSurface, // The slightly elevated dark background
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: _obscureText,
        keyboardType: widget.keyboardType,
        style: const TextStyle(color: AppColors.white), // White text for contrast
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: AppStyles.bodyMedium().copyWith(
            color: AppColors.grey,
          ),
          border: InputBorder.none, // Removes the default underline
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),

          // Only show the suffix icon if it's a password field
          suffixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              color: AppColors.grey,
              size: 20,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )
              : null,
        ),
      ),
    );
  }
}