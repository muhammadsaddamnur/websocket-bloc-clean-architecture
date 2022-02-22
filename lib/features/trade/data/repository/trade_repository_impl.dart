import 'package:coinapp/features/trade/data/datasources/trade_datasource.dart';
import 'package:coinapp/features/trade/domain/entities/trade.dart';
import 'package:coinapp/core/errors/failure.dart';
import 'package:coinapp/features/trade/domain/repository/trade_repository.dart';
import 'package:dartz/dartz.dart';

class TradeRepositoryImpl extends TradeRepository {
  final TradeDatasource datasource;

  TradeRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, Stream<Trade>>> streamTrade(String symbol) async {
    try {
      final response = await datasource.streamTrade(symbol);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
