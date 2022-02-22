import 'dart:async';
import 'dart:io' show WebSocket;

import 'package:coinapp/features/trade/data/models/trade_model.dart';
import 'package:coinapp/features/trade/domain/entities/trade.dart';

import '../../../../core/errors/exceptions.dart';

abstract class TradeDatasource {
  Future<Stream<Trade>> streamTrade(String symbol);
}

class TradeDatastoreImpl extends TradeDatasource {
  WebSocket? _webSocket;
  StreamController<Trade>? _streamController;

  @override
  Future<Stream<Trade>> streamTrade(String symbol) async {
    _webSocket?.close();
    _streamController?.close();
    _streamController = StreamController<Trade>();
    try {
      _webSocket = await WebSocket.connect(
          'wss://stream.binance.com:9443/ws/$symbol@trade');
      if (_webSocket!.readyState == WebSocket.open) {
        _webSocket!.listen(
          (data) {
            final tradeModel = TradeModel.fromJson(data);
            _streamController!.add(tradeModel);
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
