import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coinapp/features/live_price/domain/entitites/price.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../domain/usecase/stream_price.dart';

part 'price_event.dart';
part 'price_state.dart';

class PriceBloc extends Bloc<PriceEvent, PriceState> {
  //usecase
  StreamPrice streamPrice;

  late StreamSubscription<InternetConnectionStatus> listener;

  StreamSubscription? _subscription;

  PriceBloc(this.streamPrice, this._subscription) : super(PriceInitial()) {
    on<InitPriceEvent>((event, emit) {
      listener = InternetConnectionChecker().onStatusChange.listen((status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            print('Data connection is available.');
            add(const StreamPriceEvent('bitcoin'));
            break;
          case InternetConnectionStatus.disconnected:
            print('You are disconnected from the internet.');
            break;
        }
      });
    });

    on<StreamPriceEvent>((event, emit) async {
      if (_subscription != null) {
        await _subscription!.cancel();
      }
      final failureOrStream = await streamPrice(Params(event.symbol));
      failureOrStream.fold(
        (failure) => const PriceError('idk'),
        (stream) {
          _subscription = stream.listen((ev) => add(_updateState(ev.value)))
            ..onError((_) => print('wkwk'));
        },
      );
    });

    on<_updateState>((event, emit) {
      emit(PriceLoaded(Price(event.value)));
    });
  }

  @override
  Future<void> close() {
    listener.cancel();
    _subscription!.cancel();
    return super.close();
  }
}
