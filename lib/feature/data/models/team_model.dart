import 'package:flutter/material.dart';
import 'package:nba_app/feature/domain/entities/team.dart';

class TeamModel extends Team {
  TeamModel({@required int id, @required String name}): super(id: id, name: name);

  factory TeamModel.fromJson(Map<String, dynamic> map) {
    return TeamModel(id: map["id"], name: map["name"]);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["name"] = name;
    return data;
  }
}