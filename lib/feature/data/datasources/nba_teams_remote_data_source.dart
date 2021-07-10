import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nba_app/core/error/failures.dart';
import 'package:nba_app/feature/data/models/nba_teams_model.dart';
import 'package:http/http.dart' as http;

abstract class NbaTeamsRemoteDataSource {
  Future<NbaTeamsModel> getNbaTeams();
}

class NbaTeamsRemoteDataSourceImpl implements NbaTeamsRemoteDataSource {
  final http.Client client;

  NbaTeamsRemoteDataSourceImpl({@required this.client});

  @override
  Future<NbaTeamsModel> getNbaTeams() async {
    final response = await client.get(
      "http://localhost:3000/channel",
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return NbaTeamsModel.fromJson(json.decode(response.body));
    } else {
      throw ServerFailure();
    }
  }
}
