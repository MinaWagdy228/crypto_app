import 'package:flutter/material.dart';
import '../../../../core/theme/AppColors.dart';
import '../../../../core/theme/AppStyles.dart';
import '../../../../data/model/MarketCoinModel.dart';

class WalletCoinTile extends StatelessWidget {
  final MarketCoinModel coin;

  const WalletCoinTile({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    const double mockedHoldingAmount = 2.5;
    final double totalValue = mockedHoldingAmount * coin.currentPrice;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        children: [
          // 1. Coin Image
          ClipOval(
            child: Image.network(
              coin.image,
              width: 48,
              height: 48,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.monetization_on,
                color: AppColors.grey,
                size: 48,
              ),
            ),
          ),
          const SizedBox(width: 16),

          // 2. Name & Symbol
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coin.name,
                  style: AppStyles.bodyLarge(color: AppColors.white)
                      .copyWith(fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  coin.symbol,
                  style: AppStyles.bodyMedium(color: AppColors.grey),
                ),
              ],
            ),
          ),

          // 3. Balance & Value (Right Aligned)
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                mockedHoldingAmount.toStringAsFixed(2), // Mocked holding amount
                style: AppStyles.bodyLarge(color: AppColors.white)
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                '\$${totalValue.toStringAsFixed(2)}',
                style: AppStyles.bodyMedium(color: AppColors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}