import '../../../data/model/MarketCoinModel.dart';

abstract class CoinStates {}

class CoinLoadingState extends CoinStates {}

class CoinSuccessState extends CoinStates {
  final List<MarketCoinModel> coins;

  CoinSuccessState(this.coins);
}

class CoinErrorState extends CoinStates {
  final String errorMessage;

  CoinErrorState(this.errorMessage);
}
