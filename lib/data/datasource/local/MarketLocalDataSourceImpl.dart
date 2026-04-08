import 'package:hive/hive.dart';
import '../../../../data/model/MarketCoinModel.dart';
import 'MarketLocalDataSource.dart';

class MarketLocalDataSourceImpl implements MarketLocalDataSource {
  final Box<MarketCoinModel> favoritesBox;

  MarketLocalDataSourceImpl({required this.favoritesBox});

  @override
  Future<List<MarketCoinModel>> getFavorites() async {
    return favoritesBox.values.toList();
  }

  @override
  Future<void> toggleFavorite(MarketCoinModel coin) async {
    if (favoritesBox.containsKey(coin.id)) {
      await favoritesBox.delete(coin.id);
    } else {
      await favoritesBox.put(coin.id, coin);
    }
  }

  @override
  bool isFavorite(String coinId) {
    return favoritesBox.containsKey(coinId);
  }
}