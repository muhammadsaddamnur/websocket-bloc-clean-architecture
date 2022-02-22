import 'package:coinapp/core/services/hive/models/hive_ticker_type_adaptor.dart';
import 'package:coinapp/features/mini_ticker/presenter/screens/mini_ticker_screen.dart';
import 'package:coinapp/features/trade/presenter/screens/trade_screen.dart';
import 'package:coinapp/features/live_price/presenter/bloc/price_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'features/mini_ticker/presenter/bloc/mini_ticker_bloc.dart';
import 'features/trade/presenter/bloc/trade_bloc.dart';
import 'features/live_price/presenter/screens/price_screen.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(HiveTickerTypeAdaptorAdapter());
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<PriceBloc>()),
        BlocProvider(create: (context) => getIt<TradeBloc>()),
        BlocProvider(create: (context) => getIt<MiniTickerBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Dashboard(),
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ElevatedButton(
              onPressed: () async {
                var box = await Hive.openBox<HiveTickerTypeAdaptor>('myBox');

                var ticker = HiveTickerTypeAdaptor()..symbol = 'btcusdt';
                box.add(ticker);
                box.watch().map(
                      (boxEvent) => print(box.values),
                    );
                // print(box.getAt(0)!.symbol); // Dave - 22
              },
              child: Text('Test Hive')),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const PriceScreen(title: 'title')));
              },
              child: Text('Coincap.io')),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const TradeScreen(title: 'title')));
              },
              child: Text('binance - trade')),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const MiniTickerScreen(title: 'title')));
              },
              child: Text('binance - mini ticker')),
        ],
      ),
    );
  }
}
