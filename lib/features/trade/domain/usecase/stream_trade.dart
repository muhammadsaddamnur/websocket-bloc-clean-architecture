import 'package:coinapp/core/errors/failure.dart';
import 'package:coinapp/core/usecase/usecase.dart';
import 'package:coinapp/features/trade/domain/entities/trade.dart';
import 'package:coinapp/features/trade/domain/repository/trade_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class StreamTrade extends Usecase<Stream<Trade>, Params> {
  final TradeRepository repository;

  StreamTrade(this.repository);

  @override
  Future<Either<Failure, Stream<Trade>>> call(Params params) {
    return repository.streamTrade(params.symbol);
  }
}

class Params extends Equatable {
  final String symbol;

  const Params(this.symbol);

  @override
  List<Object?> get props => [symbol];
}
