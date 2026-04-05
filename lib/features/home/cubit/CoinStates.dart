import '../../../data/model/CoinModel.dart';

abstract class CoinStates {}

class CoinLoadingState extends CoinStates {}

class CoinSuccessState extends CoinStates {
  final List<CoinModel> coins;

  CoinSuccessState(this.coins);
}

class CoinErrorState extends CoinStates {
  final String errorMessage;

  CoinErrorState(this.errorMessage);
}
