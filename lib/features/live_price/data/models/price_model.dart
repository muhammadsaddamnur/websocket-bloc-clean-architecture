import 'dart:convert';

import 'package:coinapp/features/live_price/domain/entities/price.dart';

class PriceModel extends Price {
  const PriceModel(double value) : super(value);

  factory PriceModel.fromJson(
    String coin,
    String response,
  ) {
    final data = jsonDecode(response);
    print(coin);
    print(data);
    return PriceModel(double.parse(data[coin]));
  }

  @override
  List<Object> get props => [value];
}
