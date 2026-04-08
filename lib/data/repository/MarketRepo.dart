import '../../../../data/model/MarketCoinModel.dart';
import '../model/SearchCoinModel.dart';

abstract class MarketRepo {
  // Remote call
  Future<List<MarketCoinModel>> getMarketCoins();

  // Local calls for the Wallet/Favorites
  Future<List<MarketCoinModel>> getFavoriteCoins();

  Future<void> toggleFavorite(MarketCoinModel coin);

  bool isFavorite(String coinId);

  // Search functionality
  Future<List<SearchCoinModel>> searchCoins(String query);

  // Get coins by their IDs for favorites
  Future<List<MarketCoinModel>> getCoinsByIds(List<String> ids);

  // Update the local favorites list with the latest data from the remote source
  Future<void> updateFavorites(List<MarketCoinModel> coins);
}
