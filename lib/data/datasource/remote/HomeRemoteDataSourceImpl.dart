import 'package:crypto_app/core/constants/ApiConstants.dart';
import 'package:crypto_app/core/network/DioHelper.dart';
import 'package:crypto_app/data/model/MarketCoinModel.dart';

import 'HomeRemoteDataSource.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource  {
  late final DioHelper dioHelper;

  HomeRemoteDataSourceImpl(){
    dioHelper = DioHelper();
  }

  @override
  Future<List<MarketCoinModel>> getCoins() async {
    final response = await dioHelper.get(
        path: ApiConstants.coinGeckoBaseUrl + ApiConstants.coinGeckoMarkets,
        queryParameters: {
          'vs_currency': 'usd',
          'order': 'market_cap_desc',
          'per_page': 5,
          'page': 1,
          'sparkline': false,
        }
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((json) => MarketCoinModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load top coins');
    }
  }
}