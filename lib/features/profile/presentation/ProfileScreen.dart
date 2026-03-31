import 'package:flutter/material.dart';

import '../../../../core/theme/AppColors.dart';
import '../../../../core/theme/AppStyles.dart';
import '../../../../core/widgets/PrimaryButton.dart';
import '../../../core/widgets/ProfileAvatar.dart';
import '../../../core/widgets/ProfileEditableField.dart';

// 1. Define the UI states
enum ProfileMode { view, edit }

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

// Screen starts in View mode
ProfileMode _mode = ProfileMode.view;

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileMode _mode = ProfileMode.view;

  // --- Add these Controllers ---
  final TextEditingController _usernameController = TextEditingController(
    text: 'Username1234',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'example@mail.com',
  );
  final TextEditingController _mobileController = TextEditingController(
    text: '+1 234 567 8900',
  );
  final TextEditingController _passwordController = TextEditingController(
    text: 'password123',
  );

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ... rest of your existing code
  void _toggleMode() {
    setState(() {
      _mode = _mode == ProfileMode.view ? ProfileMode.edit : ProfileMode.view;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isViewMode = _mode == ProfileMode.view;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Column(
          children: [
            // 2. Dynamic App Bar
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (!isViewMode) {
                        _toggleMode(); // Cancel edit and go back to view
                      } else {
                        Navigator.pop(context); // Exit screen
                      }
                    },
                    child: const Icon(Icons.arrow_back, color: AppColors.grey),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    isViewMode ? 'Profile' : 'Edit Profile',
                    style: AppStyles.titleLarge(color: AppColors.white),
                  ),
                ],
              ),
            ),

            // 3. Scrollable Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),

                    ProfileAvatar(
                      isEditMode: !isViewMode,
                      onEditAvatarTapped: () {
                        // TODO: Show BottomSheet to pick image (Gallery/Camera)
                        print("Open image picker");
                      },
                    ),

                    const SizedBox(height: 16),
                    // Space before the Username text

                    // User's Name displayed below the avatar
                    Text(
                      'User1234',
                      style: AppStyles.titleMedium(color: AppColors.white),
                    ),

                    const SizedBox(height: 32),

                    ProfileEditableField(
                      label: 'Username',
                      displayValue: _usernameController.text,
                      isEditMode: !isViewMode,
                      controller: _usernameController,
                    ),
                    ProfileEditableField(
                      label: 'Email',
                      displayValue: _emailController.text,
                      isEditMode: !isViewMode,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    ProfileEditableField(
                      label: 'Mobile Number',
                      displayValue: _mobileController.text,
                      isEditMode: !isViewMode,
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                    ),
                    ProfileEditableField(
                      label: 'Password',
                      displayValue: _passwordController.text,
                      // Obscured automatically by our widget
                      isEditMode: !isViewMode,
                      controller: _passwordController,
                      isPassword: true,
                    ),
                  ],
                ),
              ),
            ),

            // 4. Bottom Action Buttons
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: isViewMode
                  ? PrimaryButton(
                      text: 'Edit Profile',
                      width: double.infinity,
                      onPressed: _toggleMode,
                    )
                  : Row(
                      children: [
                        // Custom grey button for Cancel to match Figma
                        Expanded(
                          child: GestureDetector(
                            onTap: _toggleMode,
                            child: Container(
                              height: 56, // Standard touch target height
                              decoration: BoxDecoration(
                                color: AppColors.grey,
                                borderRadius: BorderRadius.circular(
                                  16,
                                ), // Assuming rounded corners match PrimaryButton
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Cancel',
                                style: AppStyles.button(color: AppColors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: PrimaryButton(
                            text: 'Save Changes',
                            onPressed: () {
                              // TODO: Execute Save via ViewModel
                              _toggleMode();
                            },
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
