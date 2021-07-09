import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nba_app/feature/data/models/nba_teams_model.dart';
import 'package:nba_app/feature/data/models/team_model.dart';
import 'package:nba_app/feature/domain/entities/nba_teams.dart';
import '../../../fixtures/fixtures_reader.dart';

void main() {
  List<TeamModel> tNbaTeams = List<TeamModel>();
  tNbaTeams.add(TeamModel(id: 1, name: "Boston Celtics"));
  tNbaTeams.add(TeamModel(id: 2, name: "Brooklyn Nets"));

  final tNbaTeamsModel = NbaTeamsModel(nbaTeams: tNbaTeams);

  test(
    "should be a subclass of NbaTeams entity",
    () async {
      // assert
      expect(tNbaTeamsModel, isA<NbaTeams>());
    },
  );

  group("fromJson", () {
    test(
      "Should return a valid model",
      () async {
        //arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture("teams.json"));

        //act
        final NbaTeamsModel result = NbaTeamsModel.fromJson(jsonMap);

        //assert
        expect(result, tNbaTeamsModel);
      },
    );
  });

  // group("toJson", () {
  //   test(
  //     "should return a JSON map containing the proper data (list team) inside teams object",
  //         () async {
  //       //act
  //           final result = tNbaTeamsModel.toJson();
  //     },
  //   );
  // });
}
