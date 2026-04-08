import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/MarketRepo.dart';
import 'WalletStates.dart';

class WalletCubit extends Cubit<WalletStates> {
  final MarketRepo marketRepo;

  WalletCubit({required this.marketRepo}) : super(WalletInitialState());

  Future<void> loadFavorites() async {
    emit(WalletLoadingState());
    try {
      final favorites = await marketRepo.getFavoriteCoins();
      emit(WalletSuccessState(favorites));
    } catch (e) {
      emit(WalletErrorState(e.toString()));
    }
  }
}