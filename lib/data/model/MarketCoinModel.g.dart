// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MarketCoinModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MarketCoinModelAdapter extends TypeAdapter<MarketCoinModel> {
  @override
  final int typeId = 1;

  @override
  MarketCoinModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MarketCoinModel(
      id: fields[0] as String,
      symbol: fields[1] as String,
      name: fields[2] as String,
      image: fields[3] as String,
      currentPrice: fields[4] as double,
      priceChangePercentage24h: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, MarketCoinModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.symbol)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.currentPrice)
      ..writeByte(5)
      ..write(obj.priceChangePercentage24h);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MarketCoinModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
