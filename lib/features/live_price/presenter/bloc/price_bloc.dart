import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coinapp/features/live_price/domain/entitites/price.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecase/stream_price.dart';

part 'price_event.dart';
part 'price_state.dart';

class PriceBloc extends Bloc<PriceEvent, PriceState> {
  //usecase
  StreamPrice streamPrice;

  StreamSubscription? _subscription;

  PriceBloc(this.streamPrice, this._subscription) : super(PriceInitial()) {
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
    _subscription!.cancel();
    return super.close();
  }
}
