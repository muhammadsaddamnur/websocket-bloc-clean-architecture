import 'package:equatable/equatable.dart';

class Price extends Equatable{
  final double value;

  const Price(this.value);

  @override
  List<Object?> get props => [value];
}