import '../../../../data/model/MarketCoinModel.dart';

abstract class MarketStates {}

class MarketInitialState extends MarketStates {}

class MarketLoadingState extends MarketStates {}

class MarketSuccessState extends MarketStates {
  final List<MarketCoinModel> coins;
  final List<String> favoriteCoinIds;

  MarketSuccessState({
    required this.coins,
    required this.favoriteCoinIds,
  });
}

class MarketErrorState extends MarketStates {
  final String errorMessage;
  MarketErrorState(this.errorMessage);
}