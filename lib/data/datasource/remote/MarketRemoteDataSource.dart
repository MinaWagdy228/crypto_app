import '../../../../data/model/MarketCoinModel.dart';
import '../../model/SearchCoinModel.dart';

abstract class MarketRemoteDataSource {
  Future<List<MarketCoinModel>> getMarketCoins();
  Future<List<SearchCoinModel>> searchCoins(String query);
}