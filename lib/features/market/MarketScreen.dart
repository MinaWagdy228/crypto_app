import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routing/AppRoutes.dart';
import '../../../../core/theme/AppColors.dart';
import '../../core/widgets/CustomAppBar.dart';
import 'cubit/MarketCubit.dart';
import 'cubit/MarketStates.dart';
import 'widgets/MarketCoinTile.dart';
import 'widgets/MarketTabBar.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  int _selectedTabIndex = 1;

  @override
  void initState() {
    super.initState();
    context.read<MarketCubit>().fetchMarketData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Column(
          children: [
            HomeAppBar(
              onAvatarTapped: () => Navigator.pushNamed(context, AppRoutes.profile),
              onSearchTapped: () => print('Search Tapped'),
              onScanTapped: () => print('Scan Tapped'),
              onNotifTapped: () => print('Notif Tapped'),
            ),

            MarketTabBar(
              selectedIndex: _selectedTabIndex,
              onTabTapped: (index) {
                setState(() => _selectedTabIndex = index);
              },
            ),
            const SizedBox(height: 24),

            Expanded(
              child: BlocBuilder<MarketCubit, MarketStates>(
                builder: (context, state) {
                  if (state is MarketLoadingState || state is MarketInitialState) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColors.primary),
                    );
                  }

                  if (state is MarketErrorState) {
                    return Center(
                      child: Text(
                        'Failed to load market data: ${state.errorMessage}',
                        style: const TextStyle(color: Colors.redAccent),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  if (state is MarketLoadedState) {
                    final coins = state.coins;

                    if (coins.isEmpty) {
                      return const Center(
                        child: Text('No coins found.', style: TextStyle(color: Colors.white)),
                      );
                    }

                    return RefreshIndicator(
                      color: AppColors.primary,
                      backgroundColor: AppColors.darkSurface,
                      onRefresh: () async {
                        await context.read<MarketCubit>().fetchMarketData();
                      },
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        itemCount: coins.length,
                        itemBuilder: (context, index) {
                          final coin = coins[index];
                          final isFavorite = state.favoriteCoinIds.contains(coin.id);

                          return MarketCoinTile(
                            coin: coin,
                            isFavorite: isFavorite,
                            onFavoriteTapped: () {
                              context.read<MarketCubit>().toggleFavorite(coin);
                            },
                          );
                        },
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}