import '../../../../data/model/MarketCoinModel.dart';
import '../datasource/local/MarketLocalDataSource.dart';
import '../datasource/remote/MarketRemoteDataSource.dart';
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
}