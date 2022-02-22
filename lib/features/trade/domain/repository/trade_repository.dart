import 'package:coinapp/core/errors/failure.dart';
import 'package:coinapp/features/trade/domain/entities/trade.dart';
import 'package:dartz/dartz.dart';

abstract class TradeRepository {
  Future<Either<Failure, Stream<Trade>>> streamTrade(String symbol);
}
