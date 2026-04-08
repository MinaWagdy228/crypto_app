
import '../../model/MarketCoinModel.dart';

abstract class HomeRemoteDataSource {
  Future<List<MarketCoinModel>> getCoins();
}
