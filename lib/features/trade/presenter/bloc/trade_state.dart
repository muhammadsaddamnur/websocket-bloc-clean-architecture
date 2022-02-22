part of 'trade_bloc.dart';

abstract class TradeState {
  const TradeState();
}

class TradeInitial extends TradeState {}

class TradeLoading extends TradeState {}

class TradeLoaded extends TradeState {
  final Trade trade;

  const TradeLoaded(this.trade);
}

class TradeError extends TradeState {
  final String message;

  const TradeError(this.message);
}
