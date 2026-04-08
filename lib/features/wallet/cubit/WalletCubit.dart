import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/MarketRepo.dart';
import 'WalletStates.dart';

class WalletCubit extends Cubit<WalletStates> {
  final MarketRepo marketRepo;

  WalletCubit({required this.marketRepo}) : super(WalletInitialState());

  Future<void> loadFavorites() async {
    emit(WalletLoadingState());

    try {
      final localFavorites = await marketRepo.getFavoriteCoins();

      if (localFavorites.isEmpty) {
        emit(WalletSuccessState([]));
        return;
      }

      emit(WalletSuccessState(localFavorites));

      final ids = localFavorites.map((c) => c.id).toList();
      final liveCoins = await marketRepo.getCoinsByIds(ids);

      await marketRepo.updateFavorites(liveCoins);

      emit(WalletSuccessState(liveCoins));
    } catch (e) {
      print("Could not fetch live prices: $e");
    }
  }
}
