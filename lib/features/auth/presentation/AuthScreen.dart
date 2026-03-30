import 'package:flutter/material.dart';
import '../../../core/constants/AppAssets.dart';
import '../../../core/theme/AppColors.dart';
import '../../../core/theme/AppStyles.dart';
import '../../../core/widgets/CustomTextField.dart';
import '../../../core/widgets/PrimaryButton.dart';
import '../../../core/widgets/SocialLoginButton.dart';

// 1. Define the states our screen can be in
enum AuthMode { signIn, signUp }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // Screen States
  AuthMode _authMode = AuthMode.signIn; // Defaults to Sign In
  bool _isEmailMethod = true;           // Defaults to Email input

  // Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Helper booleans to make the UI code cleaner
    final isSignIn = _authMode == AuthMode.signIn;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Top Bar: Close Button & The Custom Toggle Tab
              Row(
                children: [
                  const Spacer(),
                  // Our custom pill toggle
                  _buildAuthToggleTab(),
                  const Spacer(),
                  const SizedBox(width: 48), // Balancing the close button width
                ],
              ),
              const SizedBox(height: 32),

              // 2. Dynamic Main Title
              Text(
                isSignIn ? 'Sign in' : 'Sign up',
                style: AppStyles.titleLarge(),
              ),
              const SizedBox(height: 32),

              // 3. Dynamic Input Fields (Email vs Mobile)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _isEmailMethod ? 'Email' : 'Mobile Number',
                    style: AppStyles.bodyMedium(),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isEmailMethod = !_isEmailMethod;
                      });
                    },
                    child: Text(
                      _isEmailMethod
                          ? (isSignIn ? 'Sign in with mobile' : 'Register with mobile')
                          : (isSignIn ? 'Sign in with email' : 'Register with email'),
                      style: AppStyles.bodyMedium().copyWith(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              if (_isEmailMethod)
                CustomTextField(
                  hintText: isSignIn ? 'Enter your email' : 'Please enter email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                )
              else
                CustomTextField(
                  hintText: isSignIn ? 'Enter your mobile' : 'Please enter mobile',
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                ),

              const SizedBox(height: 24),

              // 4. Password Field
              Text('Password', style: AppStyles.bodyMedium()),
              const SizedBox(height: 12),
              CustomTextField(
                hintText: isSignIn ? 'Enter your password' : 'Please enter password',
                controller: _passwordController,
                isPassword: true,
              ),

              // 5. Forgot Password (ONLY shows on Sign In)
              if (isSignIn) ...[
                const SizedBox(height: 16),
                Text(
                  'Forgot password?',
                  style: AppStyles.bodyMedium().copyWith(color: AppColors.primary),
                ),
                const SizedBox(height: 32),
              ] else ...[
                const SizedBox(height: 40), // Taller gap for Sign Up
              ],

              // 6. Primary Action Button
              PrimaryButton(
                text: isSignIn ? 'Sign in' : 'Sign up',
                width: double.infinity,
                onPressed: () {
                  // TODO: Connect to Auth ViewModel logic
                  print(isSignIn ? "Executing Sign In..." : "Executing Sign Up...");
                },
              ),
              const SizedBox(height: 32),

              // 7. Social Logins
              Center(
                child: Text('Or login with', style: AppStyles.bodyMedium()),
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

              // 8. Fingerprint Icon (ONLY shows on Sign In)
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
                      Text('Use fingerprint instead?', style: AppStyles.bodyMedium()),
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
  }

  // --- CUSTOM WIDGETS ---

  // Builds the pill-shaped "Sign in / Sign up" toggle at the top
  Widget _buildAuthToggleTab() {
    return Container(
      height: 40,
      width: 200, // Fixed width to match the Figma proportions
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.darkSurface, // The background of the pill
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildTabSegment(
            title: 'Sign in',
            mode: AuthMode.signIn,
          ),
          _buildTabSegment(
            title: 'Sign up',
            mode: AuthMode.signUp,
          ),
        ],
      ),
    );
  }

  // Builds the individual clickable segments inside the toggle tab
  Widget _buildTabSegment({required String title, required AuthMode mode}) {
    final isActive = _authMode == mode;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _authMode = mode;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            // Active tab gets a slightly lighter color to stand out,
            // Inactive tab stays transparent to blend into the pill background
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