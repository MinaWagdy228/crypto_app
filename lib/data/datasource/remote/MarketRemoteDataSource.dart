import '../../../../data/model/MarketCoinModel.dart';

abstract class MarketRemoteDataSource {
  Future<List<MarketCoinModel>> getMarketCoins();
}