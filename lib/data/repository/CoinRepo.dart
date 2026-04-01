import 'package:crypto_app/data/model/CoinModel.dart';

abstract class Coinrepo {
  Future<List<CoinModel>> getTopCoins();
}