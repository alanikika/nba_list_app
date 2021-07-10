import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nba_app/core/error/failures.dart';
import 'package:nba_app/core/platform/network_info.dart';
import 'package:nba_app/feature/data/datasources/nba_teams_remote_data_source.dart';
import 'package:nba_app/feature/data/models/nba_teams_model.dart';
import 'package:nba_app/feature/data/models/team_model.dart';
import 'package:nba_app/feature/data/repositories/nba_teams_repository_impl.dart';
import 'package:nba_app/feature/domain/entities/nba_teams.dart';

class MockRemoteDataSource extends Mock implements NbaTeamsRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetWorkInfo {}

void main() {
  NbaTeamsRepositoryImpl repositoryImpl;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = NbaTeamsRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      netWorkInfo: mockNetworkInfo,
    );
  });

  group("getNbaTeams", () {
    List<TeamModel> listNbaTeam = List<TeamModel>();
    listNbaTeam.add(TeamModel(id: 1, name: "Boston Celtics"));
    listNbaTeam.add(TeamModel(id: 2, name: "Brooklyn Nets"));

    final tNbaTeamsModel = NbaTeamsModel(nbaTeams: listNbaTeam);
    final NbaTeams tNbaTeams = tNbaTeamsModel;

    test(
      "Should check device is online",
      () async {
        //arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        //act
        repositoryImpl.getNbaTeams();

        //assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    group("Device is online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        "Should return remote data (list nba team) when call to remote data is success",
        () async {
          //arrange
          when(mockRemoteDataSource.getNbaTeams())
              .thenAnswer((_) async => tNbaTeamsModel);

          //act
          final result = await repositoryImpl.getNbaTeams();

          //assert
          verify(mockRemoteDataSource.getNbaTeams());
          expect(result, equals(Right(tNbaTeams)));
        },
      );

      test(
        "Should return server failure when call the remote data source is unsuccessful",
            () async {
          //arrange
          when(mockRemoteDataSource.getNbaTeams()).thenThrow(ServerFailure());

          //act
          final result = await repositoryImpl.getNbaTeams();

          //assert
          verify(mockRemoteDataSource.getNbaTeams());
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });
  });
}
