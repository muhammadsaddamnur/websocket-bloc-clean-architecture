import 'dart:async';
import 'dart:io' show WebSocket;
import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/mini_ticker.dart';
import '../models/mini_ticker_model.dart';

abstract class MiniTickerDatasource {
  Future<Stream<MiniTicker>> streamMiniTicker();
}

class MiniTickerDatastoreImpl extends MiniTickerDatasource {
  WebSocket? _webSocket;
  StreamController<MiniTicker>? _streamController;

  @override
  Future<Stream<MiniTicker>> streamMiniTicker() async {
    _webSocket?.close();
    _streamController?.close();
    _streamController = StreamController<MiniTicker>();
    try {
      _webSocket = await WebSocket.connect(
          'wss://stream.binance.com:9443/ws/!miniTicker@arr');
      if (_webSocket!.readyState == WebSocket.open) {
        _webSocket!.listen(
          (data) {
            final tradeModel = MiniTickerModel.fromJson(data);
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
