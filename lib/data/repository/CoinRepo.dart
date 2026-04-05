import 'package:crypto_app/data/model/CoinModel.dart';

abstract class CoinRepo {
  Future<List<CoinModel>> getTopCoins();
}