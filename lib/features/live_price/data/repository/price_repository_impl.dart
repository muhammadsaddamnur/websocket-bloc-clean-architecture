import 'package:coinapp/features/live_price/data/datasources/price_datasource.dart';
import 'package:coinapp/features/live_price/domain/entitites/price.dart';
import 'package:coinapp/core/errors/failure.dart';
import 'package:coinapp/features/live_price/domain/repository/price_repository.dart';
import 'package:dartz/dartz.dart';

class PriceRepositoryImpl implements PriceRepository{
  final PriceDatasource priceDatasource;

  PriceRepositoryImpl(this.priceDatasource);

  @override
  Future<Either<Failure, Stream<Price>>> streamPrice(String symbol) async{
    try {
      final respose = await priceDatasource.streamPrice(symbol);
      return Right(respose);
    } catch (e) {
      print('catchE');
      print(e); //Needs implementation on ui
      return Left(ServerFailure(e.toString()));
    }
  }
}