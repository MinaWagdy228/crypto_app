import '../../../../data/model/MarketCoinModel.dart';

abstract class WalletStates {}

class WalletInitialState extends WalletStates {}

class WalletLoadingState extends WalletStates {}

class WalletSuccessState extends WalletStates {
  final List<MarketCoinModel> favoriteCoins;

  WalletSuccessState(this.favoriteCoins);
}

class WalletErrorState extends WalletStates {
  final String errorMessage;

  WalletErrorState(this.errorMessage);
}