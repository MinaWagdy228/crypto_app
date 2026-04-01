import 'package:flutter/material.dart';

import '../../../../core/theme/AppColors.dart';
import '../../../../core/theme/AppStyles.dart';
import 'CoinCard.dart';

class CoinListSection extends StatelessWidget {
  final String title;
  final List<CoinData> coins;

  const CoinListSection({
    super.key,
    required this.title,
    required this.coins,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            title,
            style: AppStyles.titleMedium(color: AppColors.black),
          ),
        ),
        const SizedBox(height: 16),

        // Horizontal Scrolling List
        SizedBox(
          height: 120, // Height of the Coin Cards
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24.0), // Starts padded, but scrolls to the edge
            clipBehavior: Clip.none, // Allows the card shadows to render outside the box without clipping
            itemCount: coins.length,
            itemBuilder: (context, index) {
              return CoinCard(coin: coins[index]);
            },
          ),
        ),
      ],
    );
  }
}