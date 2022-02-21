import 'dart:async';

import 'package:coinapp/features/live_price/presenter/bloc/price_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => getIt<PriceBloc>())],
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
      body: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyHomePage(title: 'title')));
          },
          child: Text('data')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  late StreamSubscription<InternetConnectionStatus> listener;

  @override
  void initState() {
    Future.microtask(() async {
      final bloc = BlocProvider.of<PriceBloc>(context, listen: false);
      listener = InternetConnectionChecker().onStatusChange.listen((status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            print('Data connection is available.');
            bloc.add(const StreamPriceEvent('bitcoin'));
            break;
          case InternetConnectionStatus.disconnected:
            print('You are disconnected from the internet.');
            break;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<PriceBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<PriceBloc, PriceState>(
          builder: (context, state) {
            if (state is PriceInitial) {
              return const SizedBox();
            } else if (state is PriceLoaded) {
              return Text('Bitcoin : ' + state.price.value.toString());
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bloc.add(const StreamPriceEvent('bitcoin'));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
