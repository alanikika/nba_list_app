import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:nba_app/core/error/failures.dart';
import 'package:nba_app/core/error/usecase/usecase.dart';
import 'package:nba_app/feature/domain/entities/nba_teams.dart';
import 'package:nba_app/feature/domain/repositories/nba_teams_repository.dart';

class GetNbaTeams extends UseCase<NbaTeams, NoParams>{
  final NbaTeamsRepository nbaTeamsRepository;

  GetNbaTeams({@required this.nbaTeamsRepository});

  @override
  Future<Either<Failures, NbaTeams>> call(NoParams params) async {
    return await nbaTeamsRepository.getNbaTeams();
  }
}