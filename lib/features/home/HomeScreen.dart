import 'package:crypto_app/data/datasource/remote/RemoteDataSourceImpl.dart';
import 'package:crypto_app/features/home/cubit/CoinStates.dart';
import 'package:crypto_app/features/home/widgets/ActionCard.dart';
import 'package:crypto_app/features/home/widgets/CoinCard.dart'; // Assuming CoinData is here
import 'package:crypto_app/features/home/widgets/CoinListSection.dart';
import 'package:crypto_app/core/widgets/CustomAppBar.dart';
import 'package:crypto_app/features/home/widgets/HomeMenuBottomSheet.dart';
import 'package:crypto_app/features/home/widgets/QuickActionsGrid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/DioHelper.dart';
import '../../../core/theme/AppColors.dart';
import '../../core/constants/AppAssets.dart';
import '../../core/routing/AppRoutes.dart';
import '../../data/repository/CoinRepo.dart';
import '../../data/repository/CoinRepoImpl.dart';
import '../../data/model/CoinModel.dart';
import 'cubit/CoinCubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  String _getIconForSymbol(String symbol) {
    if (symbol.contains('BTC')) return AppAssets.bitcoinBtc;
    if (symbol.contains('ETH')) return AppAssets.bitcoinBtc;
    if (symbol.contains('ADA')) return AppAssets.cardanoAda;
    if (symbol.contains('SOL')) return AppAssets.solanaSol;
    return AppAssets.bitcoinBtc;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CoinCubit(context.read<CoinRepo>())..fetchTopCoins(),
      child: Scaffold(
        backgroundColor: AppColors.darkBackground,
        body: SafeArea(
          bottom: false,
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
                    HomeMenuBottomSheet.show(context);
                  },
                ),
                const SizedBox(height: 24),

                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  padding: const EdgeInsets.only(top: 24, bottom: 120),
                  child: Column(
                    children: [
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

                      // --- STATIC RECENT COINS ---
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
                        ],
                      ),
                      const SizedBox(height: 32),

                      BlocBuilder<CoinCubit, CoinStates>(
                        builder: (context, state) {
                          if (state is CoinLoadingState) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(32.0),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else if (state is CoinErrorState) {
                            return Center(
                              child: Text(
                                'Error loading coins: ${state.errorMessage}',
                              ),
                            );
                          } else if (state is CoinSuccessState) {
                            final coins = state.coins;

                            if (coins.isEmpty) {
                              return const Center(
                                child: Text('No coins available.'),
                              );
                            }

                            final apiCoins = coins.map((coin) {
                              final formattedPrice = coin.lastPrice
                                  .toStringAsFixed(2);
                              final prefix = coin.priceChangePercent > 0
                                  ? '+'
                                  : '';
                              final formattedChange =
                                  '$prefix${coin.priceChangePercent.toStringAsFixed(2)}%';

                              return CoinData(
                                pair: coin.symbol.replaceAll('USDT', '/USDT'),
                                price: formattedPrice,
                                change: formattedChange,
                                iconPath: _getIconForSymbol(coin.symbol),
                                isPositive: coin.priceChangePercent >= 0,
                              );
                            }).toList();

                            return CoinListSection(
                              title: 'Top Coins',
                              coins: apiCoins,
                            );
                          }

                          // Fallback for any unhandled state
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
