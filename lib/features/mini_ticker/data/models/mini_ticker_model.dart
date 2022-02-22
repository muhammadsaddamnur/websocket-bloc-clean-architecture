import 'dart:convert';

import 'package:coinapp/features/mini_ticker/domain/entities/mini_ticker.dart';

class MiniTickerModel extends MiniTicker {
  const MiniTickerModel(List<MiniTickerValue> miniTicker) : super(miniTicker);

  factory MiniTickerModel.fromJson(
    String res,
  ) {
    print(res);
    List<MiniTickerValue> result = List<MiniTickerValue>.from(
      json.decode(res).map(
            (data) => MiniTickerValue(
              e: data['e'],
              E: data['E'],
              s: data['s'],
              c: data['c'],
              o: data['o'],
              h: data['h'],
              l: data['l'],
              v: data['v'],
              q: data['q'],
            ),
          ),
    );
    // result.sort(
    //   (a, b) => a.s.compareTo(b.s),
    // );

    return MiniTickerModel(result);
  }
}
