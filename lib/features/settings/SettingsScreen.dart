import 'package:crypto_app/core/constants/AppAssets.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/routing/AppRoutes.dart';
import '../../core/theme/AppColors.dart';
import '../../core/theme/AppStyles.dart';
import '../../data/datasource/local/AuthLocalDataSourceImpl.dart';
import '../../data/model/UserModel.dart';
import '../../data/repository/AuthRepo.dart';
import '../../data/repository/AuthRepoImpl.dart';
import 'widgets/SettingsTile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isLoggingOut = false;

  Future<void> _logout() async {
    setState(() => _isLoggingOut = true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final box = Hive.box<UserModel>('userBox');
      final repo = AuthRepoImpl(
        localDataSource: AuthLocalDataSourceImpl(
          box: box,
          sharedPreferences: prefs,
        ),
      );
      await repo.logoutUser();
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.auth,
        (route) => false,
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to logout. Please try again.'),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoggingOut = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Custom App Bar
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: AppColors.grey),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Settings',
                    style: AppStyles.titleLarge(color: AppColors.white),
                  ),
                ],
              ),
            ),

            // 2. The Settings List
            // Wrapped in Expanded so it takes up the rest of the screen
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  SettingsTile(
                    iconPath: AppAssets.settingsLanguage,
                    // Built-in Material Icon matching the globe
                    title: 'Language',
                    trailingText: 'English',
                    onTap: () {
                      // TODO: Open Language Bottom Sheet / Route
                      print('Language tapped');
                    },
                  ),
                  _buildDivider(),

                  SettingsTile(
                    iconPath: AppAssets.settingsCurrency,
                    title: 'Currency',
                    trailingText: 'USD',
                    onTap: () => print('Currency tapped'),
                  ),
                  _buildDivider(),

                  SettingsTile(
                    iconPath: AppAssets.settingsAppearance,
                    title: 'Appearance',
                    trailingText: 'Use Device Settings',
                    onTap: () => print('Appearance tapped'),
                  ),
                  _buildDivider(),

                  SettingsTile(
                    iconPath: AppAssets.settingsPreference,
                    title: 'Preference',
                    trailingText: 'Customize',
                    onTap: () => print('Preference tapped'),
                  ),
                  _buildDivider(),

                  SettingsTile(
                    iconPath: AppAssets.settingsAboutUs,
                    title: 'About Us',
                    trailingText: 'v1.2.3',
                    onTap: () => print('About Us tapped'),
                  ),
                  _buildDivider(),

                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _isLoggingOut ? null : _logout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        disabledBackgroundColor: Colors.red.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        _isLoggingOut ? 'Logging out...' : 'Logout',
                        textAlign: TextAlign.center,
                        style: AppStyles.bodyMedium(
                          color: AppColors.white,
                        ).copyWith(fontWeight: FontWeight.w600),
                      ),
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

  // A helper method for the subtle lines between items
  Widget _buildDivider() {
    return Divider(
      color: AppColors.darkSurface, // Very subtle dark grey line
      thickness: 1,
      height: 1, // Keeps the spacing tight
      indent: 48, // Indents the line so it doesn't go under the icon
    );
  }
}
