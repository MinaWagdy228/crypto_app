import 'package:flutter/material.dart';
import '../../../../core/theme/AppColors.dart';
import '../../../../core/theme/AppStyles.dart';
import '../../../../data/model/SearchCoinModel.dart';

class SearchCoinTile extends StatelessWidget {
  final SearchCoinModel coin;
  final bool isFavorite;
  final VoidCallback onFavoriteTapped;

  const SearchCoinTile({
    super.key,
    required this.coin,
    required this.isFavorite,
    required this.onFavoriteTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // 1. Coin Thumbnail
          ClipOval(
            child: Image.network(
              coin.thumb,
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

          // 3. Market Cap Rank Badge (If available)
          if (coin.marketCapRank != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary10,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '#${coin.marketCapRank}',
                style: AppStyles.bodySmall(color: AppColors.primary),
              ),
            ),
          const SizedBox(width: 12),

          // 4. The Unified Favorite Button
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