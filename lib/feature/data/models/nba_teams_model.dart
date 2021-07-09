import 'package:flutter/material.dart';
import 'package:nba_app/feature/data/models/team_model.dart';
import 'package:nba_app/feature/domain/entities/nba_teams.dart';

class NbaTeamsModel extends NbaTeams {
  NbaTeamsModel({@required List<TeamModel> nbaTeams})
      : super(nbaTeams: nbaTeams);

  factory NbaTeamsModel.fromJson(Map<String, dynamic> map) {
    return NbaTeamsModel(
      nbaTeams: List<TeamModel>.from(
        map["teams"].map(
          (it) => TeamModel.fromJson(it),
        ),
      ),
    );
  }
}
