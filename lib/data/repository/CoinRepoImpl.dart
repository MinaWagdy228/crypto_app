import 'package:crypto_app/data/model/CoinModel.dart';
import 'package:crypto_app/data/repository/CoinRepo.dart';

import '../datasource/remote/RemoteDataSource.dart';
import '../datasource/remote/RemoteDataSourceImpl.dart';

class Coinrepoimpl implements Coinrepo {
  late final RemoteDataSource remoteDataSource;

  Coinrepoimpl() {
    remoteDataSource = Remotedatasourceimpl();
  }

  @override
  Future<List<CoinModel>> getTopCoins() {
    return remoteDataSource.getCoins();
  }
}
