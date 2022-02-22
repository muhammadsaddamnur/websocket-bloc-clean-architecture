import 'dart:convert';

import 'package:coinapp/features/trade/domain/entities/trade.dart';

class TradeModel extends Trade {
  const TradeModel(
      {required String e,
      required int E,
      required String s,
      required int t,
      required String p,
      required String q,
      required int b,
      required int a,
      required int T,
      required bool m,
      required bool M})
      : super(
          e: e,
          E: E,
          s: s,
          t: t,
          p: p,
          q: q,
          b: b,
          a: a,
          T: T,
          m: m,
          M: M,
        );

  factory TradeModel.fromJson(
    String res,
  ) {
    final data = jsonDecode(res);
    print(data);
    return TradeModel(
      e: data['e'],
      E: data['E'],
      s: data['s'],
      t: data['t'],
      p: data['p'],
      q: data['q'],
      b: data['b'],
      a: data['a'],
      T: data['T'],
      m: data['m'],
      M: data['M'],
    );
  }
}
