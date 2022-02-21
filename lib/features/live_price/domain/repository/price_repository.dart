import 'package:coinapp/core/errors/failure.dart';
import 'package:coinapp/features/live_price/domain/entitites/price.dart';
import 'package:dartz/dartz.dart';

abstract class PriceRepository {
  Future<Either<Failure, Stream<Price>>> streamPrice(String symbol);
}