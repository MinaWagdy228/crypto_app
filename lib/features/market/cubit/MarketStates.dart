import '../../../../data/model/MarketCoinModel.dart';

abstract class MarketStates {}

class MarketInitialState extends MarketStates {}

class MarketLoadingState extends MarketStates {}

class MarketLoadedState extends MarketStates {
  final List<MarketCoinModel> coins;
  final List<String> favoriteCoinIds; // Keeps track of which hearts to fill!

  MarketLoadedState({
    required this.coins,
    required this.favoriteCoinIds,
  });
}

class MarketErrorState extends MarketStates {
  final String errorMessage;
  MarketErrorState(this.errorMessage);
}