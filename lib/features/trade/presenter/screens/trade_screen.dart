import 'dart:async';

import 'package:coinapp/features/trade/presenter/bloc/trade_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TradeScreen extends StatefulWidget {
  const TradeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {
  @override
  void initState() {
    Future.microtask(() async {
      final bloc = BlocProvider.of<TradeBloc>(context, listen: false);
      bloc.add(const InitTradeEvent('btcusdt'));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<TradeBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<TradeBloc, TradeState>(
          builder: (context, state) {
            if (state is TradeInitial) {
              return const SizedBox();
            } else if (state is TradeLoaded) {
              return Text('Coin : ' + state.trade.a.toString());
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bloc.add(const StreamTradeEvent('btcusdt'));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
