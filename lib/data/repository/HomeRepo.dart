
import '../model/MarketCoinModel.dart';

abstract class HomeRepo {
  Future<List<MarketCoinModel>> getTopCoins();
}