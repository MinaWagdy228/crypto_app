import 'package:flutter/material.dart';
import '../../../../core/constants/AppAssets.dart';
import '../../../../core/theme/AppColors.dart';
import '../../../../core/theme/AppStyles.dart';

class WalletBalanceCard extends StatelessWidget {
  const WalletBalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        // We use your constellation background here!
        image: const DecorationImage(
          image: AssetImage(AppAssets.withoutLogo),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Current Balance',
                style: AppStyles.bodyMedium(color: AppColors.grey),
              ),
              const Icon(Icons.visibility_off, color: AppColors.grey, size: 20),
            ],
          ),
          const SizedBox(height: 8),

          // Mocked Balance to match Figma
          Text(
            '40,059.83',
            style: AppStyles.displayMedium(color: AppColors.white),
          ),
          const SizedBox(height: 4),
          Text(
            '\$468,554.23',
            style: AppStyles.bodyMedium(color: AppColors.grey),
          ),
          const SizedBox(height: 32),

          // Action Buttons
          Row(
            children: [
              Expanded(child: _buildActionButton('Deposit', isPrimary: true)),
              const SizedBox(width: 12),
              Expanded(child: _buildActionButton('Withdraw', isPrimary: false)),
              const SizedBox(width: 12),
              Expanded(child: _buildActionButton('Transfer', isPrimary: false)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildActionButton(String title, {required bool isPrimary}) {
    return Container(
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isPrimary ? AppColors.primary : AppColors.darkSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        title,
        style: AppStyles.bodyMedium(
          color: isPrimary ? AppColors.darkBackground : AppColors.white,
        ).copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}