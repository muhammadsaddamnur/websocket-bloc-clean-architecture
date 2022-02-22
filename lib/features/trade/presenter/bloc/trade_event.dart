part of 'trade_bloc.dart';

abstract class TradeEvent extends Equatable {
  const TradeEvent();

  @override
  List<Object> get props => [];
}

class InitTradeEvent extends TradeEvent {
  final String symbol;

  const InitTradeEvent(this.symbol);

  @override
  List<Object> get props => [symbol];
}

class StreamTradeEvent extends TradeEvent {
  final String symbol;

  const StreamTradeEvent(this.symbol);
  @override
  List<Object> get props => [symbol];
}

class _updateStateTradeEvent extends TradeEvent {
  final Trade trade;

  const _updateStateTradeEvent(this.trade);
  @override
  List<Object> get props => [trade];
}
