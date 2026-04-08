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
}