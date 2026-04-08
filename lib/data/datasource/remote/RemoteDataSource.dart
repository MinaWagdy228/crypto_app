
import '../../model/MarketCoinModel.dart';

abstract class RemoteDataSource {
  Future<List<MarketCoinModel>> getCoins();
}
