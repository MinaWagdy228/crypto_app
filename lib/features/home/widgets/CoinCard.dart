import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/AppColors.dart';
import '../../../../core/theme/AppStyles.dart';

// 1. Data Model for the Coin
class CoinData {
  final String pair;
  final String price;
  final String change;
  final String iconPath;
  final bool isPositive;

  CoinData({
    required this.pair,
    required this.price,
    required this.change,
    required this.iconPath,
    required this.isPositive,
  });
}

class CoinCard extends StatelessWidget {
  final CoinData coin;

  const CoinCard({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    // Determine the theme color based on if the coin is up or down
    final Color trendColor = coin.isPositive
        ? AppColors.primary
        : AppColors.error;

    return Container(
      width: 160,
      // Fixed width for horizontal scrolling cards
      margin: const EdgeInsets.only(right: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Price and Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                coin.price,
                style: AppStyles.titleMedium(
                  color: trendColor,
                ).copyWith(fontSize: 18),
              ),
              Image.network(
                coin.iconPath,
                width: 24,
                height: 24,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.monetization_on,
                  color: AppColors.grey,
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Row 2: Pair Name and Percentage Change
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                coin.pair,
                style: AppStyles.bodySmall(
                  color: AppColors.black,
                ).copyWith(fontWeight: FontWeight.w600),
              ),
              Text(coin.change, style: AppStyles.bodySmall(color: trendColor)),
            ],
          ),

          const Spacer(),
          // Pushes the chart to the very bottom

          // Row 3: Mini Sparkline Chart Placeholder (Using CustomPaint for a native feel)
          SizedBox(
            height: 30,
            width: double.infinity,
            child: CustomPaint(
              painter: _MiniChartPainter(
                color: trendColor,
                isPositive: coin.isPositive,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 3. A lightweight painter to draw the curved lines seen in Figma
class _MiniChartPainter extends CustomPainter {
  final Color color;
  final bool isPositive;

  _MiniChartPainter({required this.color, required this.isPositive});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.5)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, size.height * (isPositive ? 0.8 : 0.2));

    // Draw a simple bezier curve to simulate market movement
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * (isPositive ? 0.2 : 0.8),
      size.width * 0.5,
      size.height * 0.5,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * (isPositive ? 0.8 : 0.2),
      size.width,
      size.height * (isPositive ? 0.1 : 0.9),
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
