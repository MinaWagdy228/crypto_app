import 'package:crypto_app/core/routing/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/AppAssets.dart';
import '../../core/theme/AppColors.dart';
import '../../core/theme/AppStyles.dart';
import '../../core/widgets/CustomTextField.dart';
import '../../core/widgets/PrimaryButton.dart';
import 'widgets/SocialLoginButton.dart';
import '../../data/model/UserModel.dart';

// Import our Cubit and States
import 'cubit/UserCubit.dart';
import 'cubit/UserStates.dart';

enum AuthMode { signIn, signUp }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthMode _authMode = AuthMode.signIn;
  bool _isEmailMethod = true;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }


  void _handleSignUp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final user = UserModel(
        username: _usernameController.text.trim(),
        email: _emailController.text.trim(),
        mobile: _mobileController.text.trim(),
        password: _passwordController.text,
      );
      context.read<UserCubit>().signUp(user);
    }
  }

  void _handleSignIn(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (_isEmailMethod) {
        context.read<UserCubit>().signInWithEmail(
          _emailController.text.trim(),
          _passwordController.text,
        );
      } else {
        context.read<UserCubit>().signInWithPhoneNumber(
          _mobileController.text.trim(),
          _passwordController.text,
        );
      }
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }

  bool _isValidPhoneNumber(String phone) {
    return RegExp(r'^\d{10}$').hasMatch(phone);
  }

  @override
  Widget build(BuildContext context) {
    final isSignIn = _authMode == AuthMode.signIn;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {
          if (state is UserErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.redAccent,
              ),
            );
          } else if (state is UserSignUpSuccessState) {
            _passwordController.clear();
            _confirmPasswordController.clear();
            setState(() {
              _authMode = AuthMode.signIn;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Sign up successful! Please sign in.'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is UserLoginSuccessState) {
            Navigator.pushReplacementNamed(context, AppRoutes.mainLayout);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Spacer(),
                        _buildAuthToggleTab(),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(height: 32),

                    Text(
                      isSignIn ? 'Sign in' : 'Sign up',
                      style: AppStyles.titleLarge(),
                    ),
                    const SizedBox(height: 32),

                    if (isSignIn) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _isEmailMethod ? 'Email' : 'Mobile Number',
                            style: AppStyles.bodyMedium(),
                          ),
                          GestureDetector(
                            onTap: () => setState(() => _isEmailMethod = !_isEmailMethod),
                            child: Text(
                              _isEmailMethod ? 'Sign in with mobile' : 'Sign in with email',
                              style: AppStyles.bodyMedium().copyWith(color: AppColors.primary),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (_isEmailMethod)
                        CustomTextField(
                          hintText: 'Enter your email',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Email is required';
                            if (!_isValidEmail(value)) return 'Enter a valid email address';
                            return null;
                          },
                        )
                      else
                        CustomTextField(
                          hintText: 'Enter your 10-digit mobile',
                          controller: _mobileController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Mobile is required';
                            if (!_isValidPhoneNumber(value)) return 'Enter exactly 10 digits';
                            return null;
                          },
                        ),
                    ] else ...[
                      Text('Username', style: AppStyles.bodyMedium()),
                      const SizedBox(height: 12),
                      CustomTextField(
                        hintText: 'Please enter username',
                        controller: _usernameController,
                        keyboardType: TextInputType.name,
                        validator: (value) => value!.isEmpty ? 'Username is required' : null,
                      ),

                      const SizedBox(height: 24),
                      Text('Mobile Number', style: AppStyles.bodyMedium()),
                      const SizedBox(height: 12),
                      CustomTextField(
                        hintText: 'Please enter 10-digit mobile',
                        controller: _mobileController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Mobile is required';
                          if (!_isValidPhoneNumber(value)) return 'Enter exactly 10 digits';
                          return null;
                        },
                      ),

                      const SizedBox(height: 24),
                      Text('Email', style: AppStyles.bodyMedium()),
                      const SizedBox(height: 12),
                      CustomTextField(
                        hintText: 'Please enter email',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Email is required';
                          if (!_isValidEmail(value)) return 'Enter a valid email address';
                          return null;
                        },
                      ),
                    ],

                    const SizedBox(height: 24),

                    Text('Password', style: AppStyles.bodyMedium()),
                    const SizedBox(height: 12),
                    CustomTextField(
                      hintText: isSignIn ? 'Enter your password' : 'Please enter password',
                      controller: _passwordController,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Password is required';
                        if (value.length < 6) return 'Password must be at least 6 characters';
                        return null;
                      },
                    ),

                    if (!isSignIn) ...[
                      const SizedBox(height: 24),
                      Text('Confirm Password', style: AppStyles.bodyMedium()),
                      const SizedBox(height: 12),
                      CustomTextField(
                        hintText: 'Please confirm password',
                        controller: _confirmPasswordController,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Confirm your password';
                          if (value != _passwordController.text) return 'Passwords do not match';
                          return null;
                        },
                      ),
                    ],

                    if (isSignIn) ...[
                      const SizedBox(height: 16),
                      Text(
                        'Forgot password?',
                        style: AppStyles.bodyMedium(color: AppColors.primary),
                      ),
                      const SizedBox(height: 32),
                    ] else ...[
                      const SizedBox(height: 40),
                    ],

                    state is UserLoadingState
                        ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                        : PrimaryButton(
                      text: isSignIn ? 'Sign in' : 'Sign up',
                      width: double.infinity,
                      onPressed: () => isSignIn ? _handleSignIn(context) : _handleSignUp(context),
                    ),
                    const SizedBox(height: 32),

                    Center(
                      child: Text(
                        isSignIn ? 'Or sign in with' : 'Or sign up with',
                        style: AppStyles.bodyMedium(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: SocialLoginButton(
                            text: 'Facebook',
                            iconPath: AppAssets.fbFacebook,
                            onPressed: () => print('Facebook tapped'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: SocialLoginButton(
                            text: 'Google',
                            iconPath: AppAssets.fbGoogle,
                            onPressed: () => print('Google tapped'),
                          ),
                        ),
                      ],
                    ),

                    if (isSignIn) ...[
                      const SizedBox(height: 48),
                      Center(
                        child: Column(
                          children: [
                            const Icon(
                              Icons.fingerprint,
                              color: AppColors.primary,
                              size: 40,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Use fingerprint instead?',
                              style: AppStyles.bodyMedium(),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAuthToggleTab() {
    return Container(
      height: 40,
      width: 200,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildTabSegment(title: 'Sign in', mode: AuthMode.signIn),
          _buildTabSegment(title: 'Sign up', mode: AuthMode.signUp),
        ],
      ),
    );
  }

  Widget _buildTabSegment({required String title, required AuthMode mode}) {
    final isActive = _authMode == mode;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          _formKey.currentState?.reset();
          setState(() {
            _authMode = mode;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF2A3038) : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: AppStyles.bodyMedium().copyWith(
              color: isActive ? AppColors.white : AppColors.grey,
              fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}