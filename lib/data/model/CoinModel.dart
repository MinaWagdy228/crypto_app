class CoinModel {
  final String symbol;
  final double lastPrice;
  final double priceChangePercent;

  CoinModel({
    required this.symbol,
    required this.lastPrice,
    required this.priceChangePercent,
  });

  factory CoinModel.fromJson(Map<String, dynamic> json) {
    return CoinModel(
      symbol: json['symbol'] ?? "UNKNOWN",
      lastPrice: double.tryParse(json['lastPrice'] ?? '') ?? 0.0,
      priceChangePercent:
      double.tryParse(json['priceChangePercent'] ?? '') ?? 0.0,
    );
  }
}
