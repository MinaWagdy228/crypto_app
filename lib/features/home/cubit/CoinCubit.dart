import 'package:crypto_app/data/model/CoinModel.dart';
import 'package:crypto_app/features/home/cubit/CoinStates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_app/data/repository/CoinRepo.dart';

class CoinCubit extends Cubit<CoinStates> {
  static CoinCubit get(context) => BlocProvider.of(context);
  final CoinRepo coinRepo;

  CoinCubit(this.coinRepo) : super(CoinLoadingState());

  void fetchTopCoins() async {
    emit(CoinLoadingState());
    try {
      var coins = await (coinRepo.getTopCoins());
      emit(CoinSuccessState(coins));
    } catch (e) {
      emit(CoinErrorState(e.toString()));
    }
  }
}
