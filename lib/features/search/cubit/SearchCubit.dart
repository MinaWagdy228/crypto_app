import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/model/SearchCoinModel.dart';
import '../../../data/repository/MarketRepo.dart';
import 'SearchStates.dart';

class SearchCubit extends Cubit<SearchStates> {
  final MarketRepo marketRepo;
  Timer? _debounceTimer;

  SearchCubit({required this.marketRepo}) : super(SearchInitial());

  void onSearchQueryChanged(String query) {
    if (query.trim().isEmpty) {
      emit(SearchInitial());
      return;
    }
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    // Start a new 500ms countdown.
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      emit(SearchLoading());
      try {
        final results = await marketRepo.searchCoins(query);
        emit(SearchSuccess(results));
      } catch (e) {
        emit(SearchError(e.toString()));
      }
    });
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}