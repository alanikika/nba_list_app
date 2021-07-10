import 'package:nba_app/feature/data/models/nba_teams_model.dart';

abstract class NbaTeamsRemoteDataSource {
  Future<NbaTeamsModel> getNbaTeams();
}