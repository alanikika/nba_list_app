import 'package:dartz/dartz.dart';
import 'package:nba_app/core/error/failures.dart';
import 'package:nba_app/feature/domain/entities/nba_teams.dart';

abstract class NbaTeamsRepository {
  Future<Either<Failures, NbaTeams>> getNbaTeams();
}