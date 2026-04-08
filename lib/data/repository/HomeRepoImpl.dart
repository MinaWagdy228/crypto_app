import 'package:crypto_app/data/repository/HomeRepo.dart';

import '../datasource/remote/HomeRemoteDataSource.dart';
import '../datasource/remote/HomeRemoteDataSourceImpl.dart';
import '../model/MarketCoinModel.dart';

class HomeRepoImpl implements HomeRepo {
  late final HomeRemoteDataSource remoteDataSource;

  HomeRepoImpl() {
    remoteDataSource = HomeRemoteDataSourceImpl();
  }

  @override
  Future<List<MarketCoinModel>> getTopCoins() {
    return remoteDataSource.getCoins();
  }
}
