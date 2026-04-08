import '../../../data/model/SearchCoinModel.dart';

abstract class SearchStates {}

class SearchInitial extends SearchStates {}

class SearchLoading extends SearchStates {}

class SearchSuccess extends SearchStates {
  final List<SearchCoinModel> results;

  SearchSuccess(this.results);
}

class SearchError extends SearchStates {
  final String message;

  SearchError(this.message);
}
