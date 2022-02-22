import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/mini_ticker.dart';
import '../bloc/mini_ticker_bloc.dart';

class MiniTickerScreen extends StatefulWidget {
  const MiniTickerScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MiniTickerScreen> createState() => _MiniTickerScreenState();
}

class _MiniTickerScreenState extends State<MiniTickerScreen> {
  @override
  void initState() {
    Future.microtask(() async {
      final bloc = BlocProvider.of<MiniTickerBloc>(context, listen: false);
      bloc.add(InitMiniTickerEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<MiniTickerBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<MiniTickerBloc, MiniTickerState>(
          builder: (context, state) {
            if (state is MiniTickerInitial) {
              return const SizedBox();
            } else if (state is MiniTickerLoaded) {
              // List coins = ['ETHBTC', 'BTCUSDT'];
              return ListView.builder(
                  // itemCount: coins.length,
                  itemBuilder: (context, index) {
                MiniTickerValue ticker = state.miniTicker.miniTicker[index];

                return ListTile(
                  title: Text(ticker.s),
                  // title: Text(coins[index].toString()),
                  // subtitle: Text(ticker.s == coins[index] ? ticker.c : ''),
                );
              });
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bloc.add(StreamMiniTickerEvent());
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
