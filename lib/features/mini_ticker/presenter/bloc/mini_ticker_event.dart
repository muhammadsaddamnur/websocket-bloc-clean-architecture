part of 'mini_ticker_bloc.dart';

abstract class MiniTickerEvent extends Equatable {
  const MiniTickerEvent();

  @override
  List<Object> get props => [];
}

class InitMiniTickerEvent extends MiniTickerEvent {}

class StreamMiniTickerEvent extends MiniTickerEvent {}

class _updateStateMiniTickerEvent extends MiniTickerEvent {
  final MiniTicker miniTicker;

  const _updateStateMiniTickerEvent(this.miniTicker);
  @override
  List<Object> get props => [miniTicker];
}
