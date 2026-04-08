class SearchCoinModel {
  final String id;
  final String name;
  final String symbol;
  final String thumb;
  final String large;
  final int? marketCapRank;

  SearchCoinModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.thumb,
    required this.large,
    this.marketCapRank,
  });

  factory SearchCoinModel.fromJson(Map<String, dynamic> json) {
    return SearchCoinModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      symbol: (json['symbol'] ?? '').toString().toUpperCase(),
      thumb: json['thumb'] ?? '',
      large: json['large'] ?? '',
      marketCapRank: json['market_cap_rank'],
    );
  }
}