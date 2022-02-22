import 'package:coinapp/features/live_price/data/datasources/price_datasource.dart';
import 'package:coinapp/features/live_price/domain/entities/price.dart';
import 'package:coinapp/core/errors/failure.dart';
import 'package:coinapp/features/live_price/domain/repository/price_repository.dart';
import 'package:dartz/dartz.dart';

class PriceRepositoryImpl implements PriceRepository {
  final PriceDatasource priceDatasource;

  PriceRepositoryImpl(this.priceDatasource);

  @override
  Future<Either<Failure, Stream<Price>>> streamPrice(String symbol) async {
    try {
      final response = await priceDatasource.streamPrice(symbol);
      return Right(response);
    } catch (e) {
      print('catchE');
      print(e); //Needs implementation on ui
      return Left(ServerFailure(e.toString()));
    }
  }
}
