import 'package:equatable/equatable.dart';

class MiniTicker extends Equatable {
  final List<MiniTickerValue> miniTicker;

  const MiniTicker(this.miniTicker);

  @override
  List<Object?> get props => [];
}

class MiniTickerValue extends Equatable {
  final String e;
  final int E;
  final String s;
  final String c;
  final String o;
  final String h;
  final String l;
  final String v;
  final String q;

  const MiniTickerValue({
    required this.e,
    required this.E,
    required this.s,
    required this.c,
    required this.o,
    required this.h,
    required this.l,
    required this.v,
    required this.q,
  });

  @override
  List<Object?> get props => [];
}
