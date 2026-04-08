import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/AppColors.dart';
import '../../../core/theme/AppStyles.dart';
import '../../../core/widgets/CustomTextField.dart';
import '../../../data/model/MarketCoinModel.dart';
import '../../data/repository/MarketRepo.dart';
import 'cubit/SearchCubit.dart';
import 'cubit/SearchStates.dart';
import 'widgets/SearchCoinTile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Inject the SearchCubit specifically for this screen
    return BlocProvider(
      create: (context) => SearchCubit(marketRepo: context.read<MarketRepo>()),
      child: Scaffold(
        backgroundColor: AppColors.darkBackground,
        body: SafeArea(
          child: Column(
            children: [
              // 1. App Bar Area
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: AppColors.grey),
                    ),
                    const SizedBox(width: 16),
                    Text('Search', style: AppStyles.titleLarge()),
                  ],
                ),
              ),

              // 2. The Search Bar (Triggers the Cubit Debouncer!)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Builder(
                    builder: (context) {
                      return CustomTextField(
                        hintText: 'Search for a coin (e.g. Bitcoin)',
                        controller: _searchController,
                        prefixIcon: const Icon(Icons.search, color: AppColors.grey),
                        onChanged: (query) {
                          // Triggers the 500ms debouncer we built earlier
                          context.read<SearchCubit>().onSearchQueryChanged(query);
                        },
                      );
                    }
                ),
              ),
              const SizedBox(height: 24),

              // 3. The Results List
              Expanded(
                child: BlocBuilder<SearchCubit, SearchStates>(
                  builder: (context, state) {
                    if (state is SearchInitial) {
                      return Center(
                        child: Text(
                          'Type to search for cryptocurrencies...',
                          style: AppStyles.bodyMedium(color: AppColors.grey),
                        ),
                      );
                    }

                    if (state is SearchLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: AppColors.primary),
                      );
                    }

                    if (state is SearchError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.redAccent),
                        ),
                      );
                    }

                    if (state is SearchSuccess) {
                      if (state.results.isEmpty) {
                        return Center(
                          child: Text(
                            'No coins found.',
                            style: AppStyles.bodyMedium(color: AppColors.grey),
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        itemCount: state.results.length,
                        itemBuilder: (context, index) {
                          final searchCoin = state.results[index];

                          // Because we don't have a stream for local UI state,
                          // we can read directly from the Repo if it's favorited!
                          final isFavorite = context.read<MarketRepo>().isFavorite(searchCoin.id);

                          return SearchCoinTile(
                            coin: searchCoin,
                            isFavorite: isFavorite,
                            onFavoriteTapped: () async {
                              final mappedCoin = MarketCoinModel(
                                id: searchCoin.id,
                                symbol: searchCoin.symbol,
                                name: searchCoin.name,
                                image: searchCoin.thumb,
                                currentPrice: 0.0, // Default to 0 until Market Screen refreshes it
                                priceChangePercentage24h: 0.0,
                              );

                              // Save it to our unified Hive Box!
                              await context.read<MarketRepo>().toggleFavorite(mappedCoin);

                              // Call setState to instantly repaint the heart icon on this screen
                              setState(() {});
                            },
                          );
                        },
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}