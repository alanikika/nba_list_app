import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Team extends Equatable {
  final int id;
  final String name;

  Team({@required this.id, @required this.name});

  @override
  List<Object> get props => [id, name];
}