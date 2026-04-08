import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/model/MarketCoinModel.dart';
import '../../../data/repository/MarketRepo.dart';
import 'MarketStates.dart';

class MarketCubit extends Cubit<MarketStates> {
  final MarketRepo marketRepo;

  MarketCubit({required this.marketRepo}) : super(MarketInitialState());

  List<MarketCoinModel> _currentCoins = [];

  Future<void> fetchMarketData() async {
    emit(MarketLoadingState());
    try {
      _currentCoins = await marketRepo.getMarketCoins();

      _emitLoadedState();
    } catch (e) {
      emit(MarketErrorState(e.toString()));
    }
  }

  Future<void> toggleFavorite(MarketCoinModel coin) async {
    try {
      await marketRepo.toggleFavorite(coin);


      if (state is MarketLoadedState) {
        _emitLoadedState();
      }
    } catch (e) {
      print("Failed to toggle favorite: $e");
    }
  }

  void _emitLoadedState() {
    final favoriteIds = _currentCoins
        .where((coin) => marketRepo.isFavorite(coin.id))
        .map((coin) => coin.id)
        .toList();

    emit(MarketLoadedState(
      coins: _currentCoins,
      favoriteCoinIds: favoriteIds,
    ));
  }
}