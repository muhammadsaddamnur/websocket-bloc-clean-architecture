// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_ticker_type_adaptor.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveTickerTypeAdaptorAdapter extends TypeAdapter<HiveTickerTypeAdaptor> {
  @override
  final int typeId = 0;

  @override
  HiveTickerTypeAdaptor read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveTickerTypeAdaptor()
      ..symbol = fields[0] as String?
      ..priceChange = fields[1] as String?
      ..priceChangePercent = fields[2] as String?
      ..weightedAvgPrice = fields[3] as String?
      ..prevClosePrice = fields[4] as String?
      ..lastPrice = fields[5] as String?
      ..lastQty = fields[6] as String?
      ..bidPrice = fields[7] as String?
      ..bidQty = fields[8] as String?
      ..askPrice = fields[9] as String?
      ..askQty = fields[10] as String?
      ..openPrice = fields[11] as String?
      ..highPrice = fields[12] as String?
      ..lowPrice = fields[13] as String?
      ..volume = fields[14] as String?
      ..quoteVolume = fields[15] as String?
      ..openTime = fields[16] as int?
      ..closeTime = fields[17] as int?
      ..firstId = fields[18] as int?
      ..lastId = fields[19] as int?
      ..count = fields[20] as int?;
  }

  @override
  void write(BinaryWriter writer, HiveTickerTypeAdaptor obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.symbol)
      ..writeByte(1)
      ..write(obj.priceChange)
      ..writeByte(2)
      ..write(obj.priceChangePercent)
      ..writeByte(3)
      ..write(obj.weightedAvgPrice)
      ..writeByte(4)
      ..write(obj.prevClosePrice)
      ..writeByte(5)
      ..write(obj.lastPrice)
      ..writeByte(6)
      ..write(obj.lastQty)
      ..writeByte(7)
      ..write(obj.bidPrice)
      ..writeByte(8)
      ..write(obj.bidQty)
      ..writeByte(9)
      ..write(obj.askPrice)
      ..writeByte(10)
      ..write(obj.askQty)
      ..writeByte(11)
      ..write(obj.openPrice)
      ..writeByte(12)
      ..write(obj.highPrice)
      ..writeByte(13)
      ..write(obj.lowPrice)
      ..writeByte(14)
      ..write(obj.volume)
      ..writeByte(15)
      ..write(obj.quoteVolume)
      ..writeByte(16)
      ..write(obj.openTime)
      ..writeByte(17)
      ..write(obj.closeTime)
      ..writeByte(18)
      ..write(obj.firstId)
      ..writeByte(19)
      ..write(obj.lastId)
      ..writeByte(20)
      ..write(obj.count);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveTickerTypeAdaptorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
