import 'package:flutter/material.dart';
import '../../../../core/theme/AppColors.dart';
import '../../../../core/theme/AppStyles.dart';
import '../../../../data/model/MarketCoinModel.dart';

class MarketCoinTile extends StatelessWidget {
  final MarketCoinModel coin;
  final bool isFavorite;
  final VoidCallback onFavoriteTapped;

  const MarketCoinTile({
    super.key,
    required this.coin,
    required this.isFavorite,
    required this.onFavoriteTapped,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = coin.priceChangePercentage24h >= 0;
    final changeColor = isPositive ? AppColors.primary : AppColors.error;
    final prefix = isPositive ? '+' : '';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              coin.image,
              width: 40,
              height: 40,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.monetization_on,
                color: AppColors.grey,
                size: 40,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // 2. Name & Symbol
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coin.name,
                  style: AppStyles.bodyLarge(color: AppColors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  coin.symbol,
                  style: AppStyles.bodySmall(color: AppColors.grey),
                ),
              ],
            ),
          ),

          // 3. Price & Change
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${coin.currentPrice.toStringAsFixed(2)}',
                style: AppStyles.bodyLarge(color: AppColors.white),
              ),
              const SizedBox(height: 4),
              Text(
                '$prefix${coin.priceChangePercentage24h.toStringAsFixed(2)}%',
                style: AppStyles.bodySmall(color: changeColor),
              ),
            ],
          ),
          const SizedBox(width: 12),

          // 4. The Favorite Button!
          GestureDetector(
            onTap: onFavoriteTapped,
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.redAccent : AppColors.grey,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}