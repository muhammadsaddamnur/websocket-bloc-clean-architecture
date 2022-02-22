import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coinapp/features/trade/domain/entities/trade.dart';
import 'package:coinapp/features/trade/domain/usecase/stream_trade.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'trade_event.dart';
part 'trade_state.dart';

class TradeBloc extends Bloc<TradeEvent, TradeState> {
  //usecase
  StreamTrade streamTrade;

  late StreamSubscription<InternetConnectionStatus> listener;

  StreamSubscription? _subscription;

  TradeBloc(this.streamTrade, this._subscription) : super(TradeInitial()) {
    on<InitTradeEvent>((event, emit) {
      listener = InternetConnectionChecker().onStatusChange.listen((status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            print('Data connection is available.');
            add(const StreamTradeEvent('btcusdt'));
            break;
          case InternetConnectionStatus.disconnected:
            print('You are disconnected from the internet.');
            break;
        }
      });
    });

    on<StreamTradeEvent>((event, emit) async {
      if (_subscription != null) {
        await _subscription!.cancel();
      }
      final failureOrStream = await streamTrade(Params(event.symbol));
      failureOrStream.fold(
        (failure) => const TradeError('idk'),
        (stream) {
          _subscription = stream.listen((ev) => add(_updateStateTradeEvent(ev)))
            ..onError((_) => print('wkwk'));
        },
      );
    });

    on<_updateStateTradeEvent>((event, emit) {
      emit(TradeLoaded(event.trade));
    });
  }

  @override
  Future<void> close() {
    listener.cancel();
    _subscription!.cancel();
    return super.close();
  }
}
