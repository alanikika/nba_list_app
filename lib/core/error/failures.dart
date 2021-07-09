import 'package:equatable/equatable.dart';

class Failures extends Equatable {

  final List properties;

  Failures(this.properties) : super();

  @override
  List<Object> get props => [properties];
}