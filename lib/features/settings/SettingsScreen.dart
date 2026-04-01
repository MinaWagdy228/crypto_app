import 'package:crypto_app/core/constants/AppAssets.dart';
import 'package:flutter/material.dart';

import '../../core/theme/AppColors.dart';
import '../../core/theme/AppStyles.dart';
import 'widgets/SettingsTile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
