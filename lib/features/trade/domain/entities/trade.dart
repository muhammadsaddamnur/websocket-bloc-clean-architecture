import 'package:equatable/equatable.dart';

class Trade extends Equatable {
  final String e;
  final int E;
  final String s;
  final int t;
  final String p;
  final String q;
  final int b;
  final int a;
  final int T;
  final bool m;
  final bool M;
  const Trade(
      {required this.e,
      required this.E,
      required this.s,
      required this.t,
      required this.p,
      required this.q,
      required this.b,
      required this.a,
      required this.T,
      required this.m,
      required this.M});

  @override
  List<Object?> get props => [];
}
