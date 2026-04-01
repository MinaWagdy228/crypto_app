import 'package:crypto_app/core/routing/AppRoutes.dart';
import 'package:crypto_app/features/market/widgets/MarketCoinTile.dart';
import 'package:crypto_app/features/market/widgets/MarketTabBar.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/AppAssets.dart';
import '../../../../core/theme/AppColors.dart';
import '../../../../core/theme/AppStyles.dart';
import '../../core/widgets/CustomAppBar.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  int _selectedTabIndex = 1; // "Spot" is selected by default in Figma

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Reused App Bar from Home Feature
            HomeAppBar(
              onAvatarTapped: () => Navigator.pushNamed(context, AppRoutes.profile),
              onSearchTapped: () => print('Search Tapped'),
              onScanTapped: () => print('Scan Tapped'),
              onNotifTapped: () => print('Notif Tapped'),
            ),

            // 2. The Custom Tab Bar
            MarketTabBar(
              selectedIndex: _selectedTabIndex,
              onTabTapped: (index) {
                setState(() => _selectedTabIndex = index);
              },
            ),
            const SizedBox(height: 24),

            // 3. The Scrolling Coin List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                children: [
                  const MarketCoinTile(
                    name: 'Bitcoin',
                    symbol: 'BTC',
                    price: '32,697.05',
                    change: '+0.81%',
                    iconPath: AppAssets.bitcoinBtc,
                    isPositive: true,
                  ),
                  const MarketCoinTile(
                    name: 'Chainlink',
                    symbol: 'LINK',
                    price: '32,697.05',
                    change: '-0.81%',
                    iconPath: AppAssets.statusSnt,
                    isPositive: false, // Placeholder icon
                  ),
                  const MarketCoinTile(
                    name: 'Cardano',
                    symbol: 'ADA',
                    price: '32,697.05',
                    change: '+0.81%',
                    iconPath: AppAssets.cardanoAda,
                    isPositive: true,
                  ),
                  const MarketCoinTile(
                    name: 'SHIBA INU',
                    symbol: 'SHIB',
                    price: '32,697.05',
                    change: '-0.81%',
                    iconPath: AppAssets.shibaInuShib,
                    isPositive: false,
                  ),
                  const MarketCoinTile(
                    name: 'HIFI',
                    symbol: 'MFT',
                    price: '32,697.05',
                    change: '-0.81%',
                    iconPath: AppAssets.hifiFinanceMft,
                    isPositive: false,
                  ),
                  const MarketCoinTile(
                    name: 'REN',
                    symbol: 'REN',
                    price: '32,697.05',
                    change: '+0.81%',
                    iconPath: AppAssets.renRen,
                    isPositive: true,
                  ),

                  const SizedBox(height: 16),

                  // 4. "Add Favorite" Button
                  GestureDetector(
                    onTap: () => print('Add Favorite tapped'),
                    child: CustomPaint(
                      painter: _DashedBorderPainter(
                        color: AppColors.darkSurface,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: AppColors.darkSurface,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add,
                                color: AppColors.grey,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Add Favorite',
                              style: AppStyles.bodyMedium(
                                color: AppColors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Padding so the bottom nav bar doesn't cover the last item
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// A simple painter to draw a dashed rounded rectangle
class _DashedBorderPainter extends CustomPainter {
  final Color color;

  _DashedBorderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const double dashWidth = 8;
    const double dashSpace = 6;
    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(16),
    );

    // We use a PathMetric to accurately draw dashes around rounded corners
    final Path path = Path()..addRRect(rrect);
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
