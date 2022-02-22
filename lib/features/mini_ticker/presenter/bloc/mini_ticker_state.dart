part of 'mini_ticker_bloc.dart';

abstract class MiniTickerState {
  const MiniTickerState();
}

class MiniTickerInitial extends MiniTickerState {}

class MiniTickerLoading extends MiniTickerState {}

class MiniTickerLoaded extends MiniTickerState {
  final MiniTicker miniTicker;

  const MiniTickerLoaded(this.miniTicker);
}

class MiniTickerError extends MiniTickerState {
  final String message;

  const MiniTickerError(this.message);
}
