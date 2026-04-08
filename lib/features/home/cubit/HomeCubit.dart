import 'package:crypto_app/features/home/cubit/HomeStates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_app/data/repository/HomeRepo.dart';

class HomeCubit extends Cubit<HomeStates> {
  static HomeCubit get(context) => BlocProvider.of(context);
  final HomeRepo homeRepo;

  HomeCubit({required this.homeRepo}) : super(CoinLoadingState());

  void fetchTopCoins() async {
    emit(CoinLoadingState());
    try {
      final coins = await (homeRepo.getTopCoins());
      emit(CoinSuccessState(coins));
    } catch (e) {
      emit(CoinErrorState(e.toString()));
    }
  }
}
