import 'package:crypto_app/core/constants/ApiConstants.dart';
import 'package:crypto_app/core/network/DioHelper.dart';
import 'package:crypto_app/data/model/CoinModel.dart';

import '../../model/MarketCoinModel.dart';
import 'RemoteDataSource.dart';

class RemoteDataSourceImpl implements RemoteDataSource  {
  late final DioHelper dioHelper;
  RemoteDataSourceImpl(){
    dioHelper = DioHelper();
  }

  @override
  Future<List<CoinModel>> getCoins() async{
    final response = await dioHelper.get(path: ApiConstants.ticker24hr,
    queryParameters: {
      'symbols': '["BTCUSDT","ETHUSDT","BNBUSDT","ADAUSDT","XRPUSDT"]'
    }
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((json) => CoinModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load coins');
    }
  }
}