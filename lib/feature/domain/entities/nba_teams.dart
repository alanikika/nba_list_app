import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:nba_app/feature/domain/entities/team.dart';

class NbaTeams extends Equatable {
  final List<Team> nbaTeams;

  NbaTeams({@required this.nbaTeams});

  @override
  List<Object> get props => [nbaTeams];
}
