import 'package:coinapp/features/live_price/data/datasources/price_datasource.dart';
import 'package:coinapp/features/live_price/data/repository/price_repository_impl.dart';
import 'package:coinapp/features/live_price/domain/repository/price_repository.dart';
import 'package:coinapp/features/live_price/presenter/bloc/price_bloc.dart';
import 'package:get_it/get_it.dart';

import 'features/live_price/domain/usecase/stream_price.dart';

GetIt getIt = GetIt.instance;

Future<void> init()async {
  getIt.registerFactory(() => PriceBloc(StreamPrice(PriceRepositoryImpl(PriceDatasourceImpl())),null));
}