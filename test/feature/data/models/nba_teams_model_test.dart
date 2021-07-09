import 'package:flutter_test/flutter_test.dart';
import 'package:nba_app/feature/data/models/nba_teams_model.dart';
import 'package:nba_app/feature/domain/entities/nba_teams.dart';
import 'package:nba_app/feature/domain/entities/team.dart';

void main() {

  List<Team> tNbaTeams = List<Team>();
  tNbaTeams.add(Team(id: 1, name: "Boston Celtics"));
  tNbaTeams.add(Team(id: 2, name: "Brooklyn Nets"));

  final tNbaTeamsModel = NbaTeamsModel(nbaTeams: tNbaTeams);

  test(
    'should be a subclass of NbaTeams entity',
        () async {
      // assert
      expect(tNbaTeamsModel, isA<NbaTeams>());
    },
  );
}