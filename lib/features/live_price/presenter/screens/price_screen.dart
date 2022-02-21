import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../bloc/price_bloc.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  @override
  void initState() {
    Future.microtask(() async {
      final bloc = BlocProvider.of<PriceBloc>(context, listen: false);
      bloc.add(const InitPriceEvent('bitcoin'));
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
