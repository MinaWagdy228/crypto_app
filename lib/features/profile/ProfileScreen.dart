import 'package:crypto_app/data/model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/AppColors.dart';
import '../../../core/theme/AppStyles.dart';
import '../../../core/widgets/PrimaryButton.dart';
import '../auth/cubit/UserCubit.dart';
import '../auth/cubit/UserStates.dart';
import 'widgets/ProfileAvatar.dart';
import 'widgets/ProfileEditableField.dart';

enum ProfileMode { view, edit }

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileMode _mode = ProfileMode.view;

  // Controllers start empty, we will fill them from the Cubit
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch the user data the moment this screen opens
    context.read<UserCubit>().fetchCurrentUser();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleMode() {
    setState(() {
      _mode = _mode == ProfileMode.view ? ProfileMode.edit : ProfileMode.view;
    });
  }

  void _saveChanges() {
    // 1. Create a new UserModel from the updated text fields
    final updatedUser = UserModel(
      username: _usernameController.text.trim(),
      email: _emailController.text.trim(),
      mobile: _mobileController.text.trim(),
      password: _passwordController.text, // In a real app, handle password changes securely
    );

    // 2. Tell the Cubit to save it to the database
    context.read<UserCubit>().updateProfile(updatedUser);
  }

  @override
  Widget build(BuildContext context) {
    final isViewMode = _mode == ProfileMode.view;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      // Use BlocConsumer to listen for success/errors and build the UI
      body: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {
          if (state is UserLoadedState) {
            // When user data is loaded, populate the text controllers!
            _usernameController.text = state.user.username;
            _emailController.text = state.user.email;
            _mobileController.text = state.user.mobile;
            _passwordController.text = state.user.password;
          } else if (state is UserProfileUpdateSuccessState) {
            // Show a success message and exit edit mode
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile updated successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            _toggleMode();
          } else if (state is UserErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        },
        builder: (context, state) {
          // Show a loader while fetching or saving data
          if (state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (!isViewMode) {
                            _toggleMode();
                          } else {
                            Navigator.pop(context);
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

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 24),

                        ProfileAvatar(
                          isEditMode: !isViewMode,
                          onEditAvatarTapped: () => print("Open image picker"),
                        ),

                        const SizedBox(height: 16),

                        // Dynamically display the username
                        Text(
                          _usernameController.text.isNotEmpty
                              ? _usernameController.text
                              : 'Loading...',
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
                          isEditMode: !isViewMode,
                          controller: _passwordController,
                          isPassword: true,
                        ),
                      ],
                    ),
                  ),
                ),

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
                      Expanded(
                        child: GestureDetector(
                          onTap: _toggleMode,
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                              color: AppColors.grey,
                              borderRadius: BorderRadius.circular(16),
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
                          onPressed: _saveChanges, // <-- Call our new function!
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}