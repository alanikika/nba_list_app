import 'package:equatable/equatable.dart';

class Failures extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failures {
  final String message;

  ServerFailure({this.message});
}

class CacheFailure extends Failures {}