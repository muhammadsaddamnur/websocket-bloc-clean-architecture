import 'dart:async';
import 'dart:io' show WebSocket;
import 'package:coinapp/features/live_price/data/models/price_model.dart';
import 'package:coinapp/features/live_price/domain/entitites/price.dart';

import '../../../../core/errors/exceptions.dart';

abstract class PriceDatasource {
  Future<Stream<Price>> streamPrice(String symbol);
}

class PriceDatasourceImpl implements PriceDatasource {
  WebSocket? _webSocket;
  StreamController<Price>? _streamController;

  @override
  Future<Stream<Price>> streamPrice(String symbol) async {
    _webSocket?.close();
    _streamController?.close();
    _streamController = StreamController<Price>();

    try {
      _webSocket =
          await WebSocket.connect('wss://ws.coincap.io/prices?assets=$symbol');
      if (_webSocket!.readyState == WebSocket.open) {
        _webSocket!.listen(
          (data) {
            print(data);
            final priceModel = PriceModel.fromJson(symbol, data);
            _streamController!.add(priceModel);
          },
          onDone: () => print('[+]Done :)'),
          onError: (err) => print('[!]Error -- ${err.toString()}'),
          cancelOnError: true,
        );
      } else {
        print('[!]Connection Denied');
      }
    } catch (err) {
      print(err);
      _streamController!.close();
      throw ServerException();
    }

    return _streamController!.stream;
  }
}
