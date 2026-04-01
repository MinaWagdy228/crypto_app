import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/AppColors.dart';
import '../../../../core/theme/AppStyles.dart';

class MarketCoinTile extends StatelessWidget {
  final String name;
  final String symbol;
  final String price;
  final String change;
  final String iconPath;
  final bool isPositive;

  const MarketCoinTile({
    super.key,
    required this.name,
    required this.symbol,
    required this.price,
    required this.change,
    required this.iconPath,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    final Color trendColor = isPositive ? AppColors.primary : AppColors.error;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        children: [
          // 1. Icon
          SvgPicture.asset(iconPath, width: 40, height: 40),
          const SizedBox(width: 16),

          // 2. Name & Symbol
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppStyles.titleMedium(
                    color: AppColors.white,
                  ).copyWith(fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(symbol, style: AppStyles.bodySmall(color: AppColors.grey)),
              ],
            ),
          ),

          // 3. Mini Chart (Middle)
          Expanded(
            flex: 3,
            child: SizedBox(
              height: 32,
              child: CustomPaint(
                painter: _MarketChartPainter(
                  color: trendColor,
                  isPositive: isPositive,
                ),
              ),
            ),
          ),

          // 4. Price & Percentage (Right)
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: AppStyles.titleMedium(
                    color: AppColors.white,
                  ).copyWith(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(change, style: AppStyles.bodySmall(color: trendColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// A more advanced painter that includes a subtle gradient fill under the line!
class _MarketChartPainter extends CustomPainter {
  final Color color;
  final bool isPositive;

  _MarketChartPainter({required this.color, required this.isPositive});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(0, size.height * (isPositive ? 0.7 : 0.3));

    // Create a dynamic, random-looking curve
    path.quadraticBezierTo(
      size.width * 0.15,
      size.height * (isPositive ? 0.2 : 0.8),
      size.width * 0.3,
      size.height * 0.5,
    );
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * (isPositive ? 0.8 : 0.2),
      size.width * 0.7,
      size.height * 0.5,
    );
    path.quadraticBezierTo(
      size.width * 0.85,
      size.height * (isPositive ? 0.3 : 0.7),
      size.width,
      size.height * (isPositive ? 0.1 : 0.9),
    );

    // Draw the line
    final strokePaint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, strokePaint);

    // Draw the subtle gradient fill below the line
    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [color.withOpacity(0.3), color.withOpacity(0.0)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(fillPath, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
