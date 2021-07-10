import 'package:dartz/dartz.dart';
import 'package:nba_app/core/error/failures.dart';
import 'package:nba_app/core/platform/network_info.dart';
import 'package:nba_app/feature/data/datasources/nba_teams_remote_data_source.dart';
import 'package:nba_app/feature/domain/entities/nba_teams.dart';
import 'package:nba_app/feature/domain/repositories/nba_teams_repository.dart';

class NbaTeamsRepositoryImpl implements NbaTeamsRepository {
  final NbaTeamsRemoteDataSource remoteDataSource;
  final NetWorkInfo netWorkInfo;

  NbaTeamsRepositoryImpl({this.remoteDataSource, this.netWorkInfo});

  @override
  Future<Either<Failures, NbaTeams>> getNbaTeams() async {
    if (await netWorkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.getNbaTeams());
      } catch (_) {
        return Left(ServerFailure(message: "Can not connect to remote source"));
      }
    } else {
      return Left(ServerFailure(message: "You are offline"));
    }
  }
}
