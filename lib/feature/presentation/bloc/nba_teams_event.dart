import 'package:equatable/equatable.dart';

abstract class NbaTeamsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchNbaTeams extends NbaTeamsEvent {

  @override
  String toString() => "Nba Teams Event => Get Nba Teams";
}