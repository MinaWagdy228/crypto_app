import 'package:crypto_app/data/model/CoinModel.dart';

abstract class RemoteDataSource {
  Future<List<CoinModel>> getCoins();
}
