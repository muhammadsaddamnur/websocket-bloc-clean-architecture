import 'package:coinapp/core/errors/failure.dart';
import 'package:coinapp/core/usecase/usecase.dart';
import 'package:coinapp/features/live_price/domain/entitites/price.dart';
import 'package:coinapp/features/live_price/domain/repository/price_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class StreamPrice implements Usecase<Stream<Price>, Params>{
  final PriceRepository repository;

  StreamPrice(this.repository);

  @override
  Future<Either<Failure, Stream<Price>>> call(Params params) {
    return repository.streamPrice(params.symbol);
  }

}

class Params extends Equatable {
  final String symbol;

  const Params(this.symbol);

  @override
  List<Object?> get props => [symbol];
}