import 'package:crypto_app/data/datasource/RemoteDataSourceImpl.dart';
import 'package:crypto_app/features/home/widgets/ActionCard.dart';
import 'package:crypto_app/features/home/widgets/CoinCard.dart'; // Assuming CoinData is here
import 'package:crypto_app/features/home/widgets/CoinListSection.dart';
import 'package:crypto_app/core/widgets/CustomAppBar.dart';
import 'package:crypto_app/features/home/widgets/HomeMenuBottomSheet.dart';
import 'package:crypto_app/features/home/widgets/QuickActionsGrid.dart';
import 'package:flutter/material.dart';

import '../../../core/network/DioHelper.dart';
import '../../../core/theme/AppColors.dart';
import '../../core/constants/AppAssets.dart';
import '../../core/routing/AppRoutes.dart';
import '../../data/repository/CoinRepoImpl.dart';
import '../../data/model/CoinModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<CoinModel>> _topCoinsFuture;

  @override
  void initState() {
    super.initState();
    // Manual Dependency Injection
    final dioHelper = DioHelper();
    final remoteDataSource = Remotedatasourceimpl(dioHelper);
    final coinRepo = Coinrepoimpl(remoteDataSource: remoteDataSource);

    _topCoinsFuture = coinRepo.getTopCoins();
  }

  // Helper method to assign local assets based on API symbol
  String _getIconForSymbol(String symbol) {
    if (symbol.contains('BTC')) return AppAssets.bitcoinBtc;
    if (symbol.contains('ETH')) return AppAssets.bitcoinBtc; // Update to ETH asset if you have it
    if (symbol.contains('ADA')) return AppAssets.cardanoAda;
    if (symbol.contains('SOL')) return AppAssets.solanaSol;
    return AppAssets.bitcoinBtc; // Fallback icon
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                    // --- DYNAMIC TOP COINS ---
                    FutureBuilder<List<CoinModel>>(
                      future: _topCoinsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(32.0),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error loading coins: ${snapshot.error}'),
                          );
                        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {

                          // Map the API CoinModels into UI CoinData objects
                          final apiCoins = snapshot.data!.map((coin) {
                            // Format prices and percentages nicely
                            final formattedPrice = coin.lastPrice.toStringAsFixed(2);
                            final prefix = coin.priceChangePercent > 0 ? '+' : '';
                            final formattedChange = '$prefix${coin.priceChangePercent.toStringAsFixed(2)}%';

                            return CoinData(
                              pair: coin.symbol.replaceAll('USDT', '/USDT'), // e.g., BTCUSDT -> BTC/USDT
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

                        return const SizedBox.shrink(); // Fallback if no data
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}