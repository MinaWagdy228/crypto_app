import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/AppColors.dart';
import '../../../core/theme/AppStyles.dart';
import '../../data/repository/MarketRepo.dart';
import 'cubit/WalletCubit.dart';
import 'cubit/WalletStates.dart';
import 'widgets/WalletBalanceCard.dart';
import 'widgets/WalletCoinTile.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // We inject the WalletCubit here and instantly load favorites
      create: (context) => WalletCubit(
        marketRepo: context.read<MarketRepo>(),
      )..loadFavorites(),

      child: Scaffold(
        backgroundColor: AppColors.darkBackground,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // Top Custom App Bar for Wallet
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Wallet', style: AppStyles.titleLarge()),
                    const Icon(Icons.history, color: AppColors.white),
                  ],
                ),
                const SizedBox(height: 24),

                // The Balance Card
                const WalletBalanceCard(),
                const SizedBox(height: 32),

                // The Dynamic List of Favorites
                Expanded(
                  child: BlocBuilder<WalletCubit, WalletStates>(
                    builder: (context, state) {
                      if (state is WalletLoadingState || state is WalletInitialState) {
                        return const Center(
                          child: CircularProgressIndicator(color: AppColors.primary),
                        );
                      }

                      if (state is WalletErrorState) {
                        return Center(
                          child: Text(
                            state.errorMessage,
                            style: const TextStyle(color: Colors.redAccent),
                          ),
                        );
                      }

                      if (state is WalletSuccessState) {
                        final coins = state.favoriteCoins;

                        if (coins.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.account_balance_wallet_outlined, size: 64, color: AppColors.grey),
                                const SizedBox(height: 16),
                                Text(
                                  'Your wallet is empty.\nGo to Markets to add favorites!',
                                  textAlign: TextAlign.center,
                                  style: AppStyles.bodyMedium(color: AppColors.grey),
                                ),
                              ],
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: coins.length,
                          itemBuilder: (context, index) {
                            return WalletCoinTile(coin: coins[index]);
                          },
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ),
                // Extra padding at the bottom so the Bottom Nav Bar doesn't cover the last coin
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}