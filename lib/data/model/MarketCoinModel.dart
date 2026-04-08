import 'package:hive/hive.dart';

part 'MarketCoinModel.g.dart';

@HiveType(typeId: 1)
class MarketCoinModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String symbol;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String image;

  @HiveField(4)
  final double currentPrice;

  @HiveField(5)
  final double priceChangePercentage24h;

  MarketCoinModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.priceChangePercentage24h,
  });

  // Factory constructor to parse CoinGecko JSON
  factory MarketCoinModel.fromJson(Map<String, dynamic> json) {
    return MarketCoinModel(
      id: json['id'] ?? '',
      symbol: (json['symbol'] ?? '').toString().toUpperCase(),
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      // Use .toDouble() to prevent casting errors if the API returns an int (e.g., 68601 instead of 68601.0)
      currentPrice: (json['current_price'] ?? 0).toDouble(),
      priceChangePercentage24h: (json['price_change_percentage_24h'] ?? 0).toDouble(),
    );
  }
}