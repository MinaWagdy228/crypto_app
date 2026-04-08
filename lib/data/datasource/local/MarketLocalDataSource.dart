import '../../../../data/model/MarketCoinModel.dart';

abstract class MarketLocalDataSource {
  Future<List<MarketCoinModel>> getFavorites();
  Future<void> toggleFavorite(MarketCoinModel coin);
  bool isFavorite(String coinId);
  Future<void> updateFavorites(List<MarketCoinModel> coins);
}