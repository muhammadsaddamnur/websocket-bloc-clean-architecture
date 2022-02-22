import 'package:coinapp/features/mini_ticker/presenter/bloc/mini_ticker_bloc.dart';
import 'package:coinapp/features/trade/data/datasources/trade_datasource.dart';
import 'package:coinapp/features/trade/domain/usecase/stream_trade.dart';
import 'package:coinapp/features/trade/presenter/bloc/trade_bloc.dart';
import 'package:coinapp/features/live_price/data/datasources/price_datasource.dart';
import 'package:coinapp/features/live_price/data/repository/price_repository_impl.dart';
import 'package:coinapp/features/live_price/domain/repository/price_repository.dart';
import 'package:coinapp/features/live_price/presenter/bloc/price_bloc.dart';
import 'package:get_it/get_it.dart';

import 'features/mini_ticker/data/datasources/mini_ticker_datasource.dart';
import 'features/mini_ticker/data/repository/mini_ticker_repository_impl.dart';
import 'features/mini_ticker/domain/usecase/stream_mini_ticker.dart';
import 'features/trade/data/repository/trade_repository_impl.dart';
import 'features/live_price/domain/usecase/stream_price.dart';

GetIt getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerFactory(() =>
      PriceBloc(StreamPrice(PriceRepositoryImpl(PriceDatasourceImpl())), null));
  getIt.registerFactory(() =>
      TradeBloc(StreamTrade(TradeRepositoryImpl(TradeDatastoreImpl())), null));
  getIt.registerFactory(() => MiniTickerBloc(
      StreamMiniTicker(MiniTickerRepositoryImpl(MiniTickerDatastoreImpl())),
      null));
}
