import 'package:crypto_app/features/home/widgets/ActionCard.dart';
import 'package:crypto_app/features/home/widgets/CoinCard.dart';
import 'package:crypto_app/features/home/widgets/CoinListSection.dart';
import 'package:crypto_app/core/widgets/CustomAppBar.dart';
import 'package:crypto_app/features/home/widgets/HomeMenuBottomSheet.dart';
import 'package:crypto_app/features/home/widgets/QuickActionsGrid.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/AppColors.dart';
import '../../core/constants/AppAssets.dart';
import '../../core/routing/AppRoutes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // We don't use a bottomNavigationBar here because it's handled by MainLayoutScreen
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        bottom: false, // Let the bottom background extend behind the nav bar
        child: SingleChildScrollView(
          child: Column(
            children: [
              HomeAppBar(
                onAvatarTapped: () =>
                    Navigator.pushNamed(context, AppRoutes.profile),
                onSearchTapped: () => print('Search tapped'),
                onScanTapped: () => print('Scan tapped'),
                onNotifTapped: () => print('Notif tapped'),
              ),

              const SizedBox(height: 16),

              QuickActionsGrid(
                onMoreTapped: () {
                  // Triggers the static method to show the bottom sheet
                  HomeMenuBottomSheet.show(context);
                },
              ),

              const SizedBox(height: 24),

              // --- LIGHT BOTTOM SECTION ---
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  // Matches Figma's light background for cards
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                // Padding at bottom to account for the floating bottom nav bar
                padding: const EdgeInsets.only(top: 24, bottom: 120),
                child: Column(
                  children: [
                    // (Ensure you have imported your updated AppAssets.dart)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        children: [
                          ActionCard(
                            title: 'P2P Trading',
                            subtitle: 'Bank Transfer, Paypal Revolut...',
                            imagePath: AppAssets.rocket,
                            onTap: () => print('P2P Trading tapped'),
                          ),
                          ActionCard(
                            title: 'Credit/Debit Card',
                            subtitle: 'Visa, Mastercard',
                            imagePath: AppAssets.creditCard,
                            onTap: () => print('Credit Card tapped'),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    CoinListSection(
                      title: 'Recent Coin',
                      coins: [
                        CoinData(
                          pair: 'BTC/BUSD',
                          price: '40,059.83',
                          change: '+0.81%',
                          iconPath: AppAssets.bitcoinBtc,
                          isPositive: true,
                        ),
                        CoinData(
                          pair: 'SOL/BUSD',
                          price: '2,059.83',
                          change: '-0.81%',
                          iconPath: AppAssets.solanaSol,
                          isPositive: false,
                        ),
                        CoinData(
                          pair: 'ETH/BUSD',
                          price: '3,105.12',
                          change: '+1.12%',
                          iconPath: AppAssets.bitcoinBtc,
                          // Placeholder if ETH asset is missing
                          isPositive: true,
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    CoinListSection(
                      title: 'Top Coins',
                      coins: [
                        CoinData(
                          pair: 'MFT/BUSD',
                          price: '40,059.83',
                          change: '+0.81%',
                          iconPath: AppAssets.hifiFinanceMft,
                          isPositive: true,
                        ),
                        CoinData(
                          pair: 'REN/BUSD',
                          price: '2,059.83',
                          change: '-0.81%',
                          iconPath: AppAssets.renRen,
                          isPositive: false,
                        ),
                        CoinData(
                          pair: 'ADA/BUSD',
                          price: '1.24',
                          change: '+4.31%',
                          iconPath: AppAssets.cardanoAda,
                          isPositive: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
