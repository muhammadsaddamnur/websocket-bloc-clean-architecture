import 'package:coinapp/core/errors/failure.dart';
import 'package:coinapp/features/mini_ticker/domain/entities/mini_ticker.dart';
import 'package:dartz/dartz.dart';

abstract class MiniTickerRepository {
  Future<Either<Failure, Stream<MiniTicker>>> streamMiniTicker();
}
