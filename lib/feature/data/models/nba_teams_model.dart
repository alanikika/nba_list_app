import 'package:nba_app/feature/domain/entities/nba_teams.dart';
import 'package:nba_app/feature/domain/entities/team.dart';

class NbaTeamsModel extends NbaTeams {
  final List<Team> nbaTeams;

  NbaTeamsModel({this.nbaTeams}) : super(nbaTeams: nbaTeams);
}
