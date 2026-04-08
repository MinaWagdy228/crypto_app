import '../../../../data/model/MarketCoinModel.dart';
import '../datasource/local/MarketLocalDataSource.dart';
import '../datasource/remote/MarketRemoteDataSource.dart';
import '../model/SearchCoinModel.dart';
import 'MarketRepo.dart';

class MarketRepoImpl implements MarketRepo {
  final MarketRemoteDataSource remoteDataSource;
  final MarketLocalDataSource localDataSource;

  MarketRepoImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<MarketCoinModel>> getMarketCoins() {
    return remoteDataSource.getMarketCoins();
  }

  @override
  Future<List<MarketCoinModel>> getFavoriteCoins() {
    return localDataSource.getFavorites();
  }

  @override
  Future<void> toggleFavorite(MarketCoinModel coin) async {
    await localDataSource.toggleFavorite(coin);
  }

  @override
  bool isFavorite(String coinId) {
    return localDataSource.isFavorite(coinId);
  }

  @override
  Future<List<SearchCoinModel>> searchCoins(String query) {
    return remoteDataSource.searchCoins(query);
  }

  @override
  Future<List<MarketCoinModel>> getCoinsByIds(List<String> ids) {
    return remoteDataSource.getCoinsByIds(ids);
  }

  @override
  Future<void> updateFavorites(List<MarketCoinModel> coins) async {
    await localDataSource.updateFavorites(coins);
  }
}
