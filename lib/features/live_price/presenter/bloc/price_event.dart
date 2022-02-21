part of 'price_bloc.dart';

abstract class PriceEvent extends Equatable {
  const PriceEvent();

  @override
  List<Object> get props => [];
}

class InitPriceEvent extends PriceEvent {
  final String symbol;

  const InitPriceEvent(this.symbol);

  @override
  List<Object> get props => [symbol];
}

class StreamPriceEvent extends PriceEvent {
  final String symbol;

  const StreamPriceEvent(this.symbol);

  @override
  List<Object> get props => [symbol];
}

class _updateState extends PriceEvent {
  final double value;

  const _updateState(this.value);

  @override
  List<Object> get props => [value];
}
