import 'package:crypto_app/data/repository/CoinRepo.dart';

import '../datasource/remote/RemoteDataSource.dart';
import '../datasource/remote/RemoteDataSourceImpl.dart';
import '../model/MarketCoinModel.dart';

class CoinRepoImpl implements CoinRepo {
  late final RemoteDataSource remoteDataSource;

  CoinRepoImpl() {
    remoteDataSource = RemoteDataSourceImpl();
  }

  @override
  Future<List<MarketCoinModel>> getTopCoins() {
    return remoteDataSource.getCoins();
  }
}
