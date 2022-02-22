import 'package:hive/hive.dart';

part 'hive_ticker_type_adaptor.g.dart';

@HiveType(typeId: 0)
class HiveTickerTypeAdaptor {
  @HiveField(0)
  String? symbol;

  @HiveField(1)
  String? priceChange;

  @HiveField(2)
  String? priceChangePercent;

  @HiveField(3)
  String? weightedAvgPrice;

  @HiveField(4)
  String? prevClosePrice;

  @HiveField(5)
  String? lastPrice;

  @HiveField(6)
  String? lastQty;

  @HiveField(7)
  String? bidPrice;

  @HiveField(8)
  String? bidQty;

  @HiveField(9)
  String? askPrice;

  @HiveField(10)
  String? askQty;

  @HiveField(11)
  String? openPrice;

  @HiveField(12)
  String? highPrice;

  @HiveField(13)
  String? lowPrice;

  @HiveField(14)
  String? volume;

  @HiveField(15)
  String? quoteVolume;

  @HiveField(16)
  int? openTime;

  @HiveField(17)
  int? closeTime;

  @HiveField(18)
  int? firstId;

  @HiveField(19)
  int? lastId;

  @HiveField(20)
  int? count;
}
