import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nba_app/feature/domain/entities/nba_teams.dart';

abstract class NbaTeamsState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends NbaTeamsState {
  @override
  String toString() => "Nba Teams State => Empty";
}

class Loading extends NbaTeamsState {
  @override
  String toString() => "Nba Teams State => Loading";
}

class Loaded extends NbaTeamsState {

  final NbaTeams nbaTeams;

  Loaded({@required this.nbaTeams});

  @override
  String toString() => "Nba Teams State => Loaded";
}

class Error extends NbaTeamsState {
  final String message;

  Error({@required this.message});

  @override
  String toString() => "Nba Teams State => Error";
}

