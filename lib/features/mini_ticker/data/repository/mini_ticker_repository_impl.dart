import 'package:coinapp/features/mini_ticker/data/datasources/mini_ticker_datasource.dart';
import 'package:coinapp/features/mini_ticker/domain/entities/mini_ticker.dart';
import 'package:coinapp/core/errors/failure.dart';
import 'package:coinapp/features/mini_ticker/domain/repoitory/mini_ticker_repository.dart';
import 'package:dartz/dartz.dart';

class MiniTickerRepositoryImpl extends MiniTickerRepository {
  final MiniTickerDatasource datasource;

  MiniTickerRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, Stream<MiniTicker>>> streamMiniTicker() async {
    try {
      final result = await datasource.streamMiniTicker();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
