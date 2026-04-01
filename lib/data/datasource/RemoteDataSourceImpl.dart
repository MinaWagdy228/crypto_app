import 'package:crypto_app/core/network/ApiConstants.dart';
import 'package:crypto_app/core/network/DioHelper.dart';
import 'package:crypto_app/data/datasource/RemoteDataSource.dart';
import 'package:crypto_app/data/model/CoinModel.dart';

class Remotedatasourceimpl implements RemoteDataSource  {
  final DioHelper dioHelper;
  Remotedatasourceimpl(this.dioHelper);

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