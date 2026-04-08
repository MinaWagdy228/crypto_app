import '../../../../core/constants/ApiConstants.dart';
import '../../../../core/network/DioHelper.dart';
import '../../../../data/model/MarketCoinModel.dart';
import 'MarketRemoteDataSource.dart';

class MarketRemoteDataSourceImpl implements MarketRemoteDataSource {
  late final DioHelper dioHelper;

  MarketRemoteDataSourceImpl(){
    dioHelper = DioHelper();
  }

  @override
  Future<List<MarketCoinModel>> getMarketCoins() async {
    final response = await dioHelper.get(
      path: ApiConstants.coinGeckoBaseUrl + ApiConstants.coinGeckoMarkets,
      queryParameters: {
        'vs_currency': 'usd',
        'order': 'market_cap_desc',
        'per_page': 50,
        'page': 1,
        'sparkline': false,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((json) => MarketCoinModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch coins from CoinGecko');
    }
  }
}