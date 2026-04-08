
import '../model/MarketCoinModel.dart';

abstract class CoinRepo {
  Future<List<MarketCoinModel>> getTopCoins();
}