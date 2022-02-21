import 'dart:convert';

import 'package:coinapp/features/live_price/domain/entitites/price.dart';

class PriceModel extends Price {
  const PriceModel(double value) : super(value);

  @override
  List<Object> get props =>[value];
   
  factory PriceModel.fromJson(String coin, String response,){
    final data = jsonDecode(response);
    print(coin);
    print(data);
    return PriceModel(double.parse(data[coin]));
  }
}