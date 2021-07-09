import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nba_app/feature/data/models/nba_teams_model.dart';
import 'package:nba_app/feature/data/models/team_model.dart';
import 'package:nba_app/feature/domain/entities/team.dart';

import '../../../fixtures/fixtures_reader.dart';

void main() {
  final TeamModel tTeamModel = TeamModel(id: 1, name: "Boston Celtics");

  test("should be a subclass of Team entity", () async {
    //assert
    expect(tTeamModel, isA<Team>());
  });

  group("fromJson", () {
    test(
      "should return a valid object team model",
      () {
        //arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture("teams.json"));

        //act
        final NbaTeamsModel teams = NbaTeamsModel.fromJson(jsonMap);
        final TeamModel result = teams.nbaTeams[0];

        //assert
        expect(result, tTeamModel);
      },
    );
  });

  group("toJson", () {
    test("should return a json object", () {
      //act
      final result = tTeamModel.toJson();

      //assert
      final expectedJson = {"id": 1, "name": "Boston Celtics"};

      expect(result, expectedJson);
    });
  });
}
