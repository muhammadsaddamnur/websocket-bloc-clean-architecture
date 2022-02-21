part of 'price_bloc.dart';

abstract class PriceState extends Equatable {
  const PriceState();
  
  @override
  List<Object> get props => [];
}

class PriceInitial extends PriceState {}


class PriceLoaded extends PriceState{
  final Price price;

  const PriceLoaded(this.price);

  @override
  List<Object> get props => [price];
}

class PriceError extends PriceState{
  final String message;

  const PriceError(this.message);

  @override
  List<Object> get props => [message];
}