import '../../../data/model/MarketCoinModel.dart';

abstract class HomeStates {}

class CoinLoadingState extends HomeStates {}

class CoinSuccessState extends HomeStates {
  final List<MarketCoinModel> coins;

  CoinSuccessState(this.coins);
}

class CoinErrorState extends HomeStates {
  final String errorMessage;

  CoinErrorState(this.errorMessage);
}
