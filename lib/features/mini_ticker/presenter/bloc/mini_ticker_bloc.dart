import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coinapp/core/usecase/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../domain/entities/mini_ticker.dart';
import '../../domain/usecase/stream_mini_ticker.dart';

part 'mini_ticker_event.dart';
part 'mini_ticker_state.dart';

class MiniTickerBloc extends Bloc<MiniTickerEvent, MiniTickerState> {
  //usecase
  StreamMiniTicker streamMiniTicker;

  late StreamSubscription<InternetConnectionStatus> listener;

  StreamSubscription? _subscription;

  MiniTickerBloc(this.streamMiniTicker, this._subscription)
      : super(MiniTickerInitial()) {
    on<InitMiniTickerEvent>((event, emit) {
      listener = InternetConnectionChecker().onStatusChange.listen((status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            print('Data connection is available.');
            add(StreamMiniTickerEvent());
            break;
          case InternetConnectionStatus.disconnected:
            print('You are disconnected from the internet.');
            break;
        }
      });
    });

    on<StreamMiniTickerEvent>((event, emit) async {
      if (_subscription != null) {
        await _subscription!.cancel();
      }
      final failureOrStream = await streamMiniTicker(NoParams());
      failureOrStream.fold(
        (failure) => const MiniTickerError('idk'),
        (stream) {
          _subscription = stream
              .listen((ev) => add(_updateStateMiniTickerEvent(ev)))
            ..onError((_) => print('wkwk'));
        },
      );
    });

    on<_updateStateMiniTickerEvent>((event, emit) {
      emit(MiniTickerLoaded(event.miniTicker));
    });
  }

  @override
  Future<void> close() {
    listener.cancel();
    _subscription!.cancel();
    return super.close();
  }
}
