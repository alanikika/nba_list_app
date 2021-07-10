import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nba_app/core/error/failures.dart';
import 'package:nba_app/core/error/usecase/usecase.dart';
import 'package:nba_app/feature/domain/entities/nba_teams.dart';
import 'package:nba_app/feature/domain/entities/team.dart';
import 'package:nba_app/feature/domain/usecases/get_nba_teams.dart';
import 'package:nba_app/feature/presentation/bloc/bloc.dart';

class MockGetNbaTeams extends Mock implements GetNbaTeams {}

void main() {
  NbaTeamsBloc bloc;
  MockGetNbaTeams mockGetNbaTeams;

  setUp(() {
    mockGetNbaTeams = MockGetNbaTeams();
    bloc = NbaTeamsBloc(nbaTeams: mockGetNbaTeams);
  });

  test(
    "Init state should be Empty State",
    () {
      //assert
      expect(bloc.initialState, equals(Empty()));
    },
  );

  group(
    "FetchNbaTeams",
    () {
      List<Team> listNbaTeam = List<Team>();
      listNbaTeam.add(Team(id: 1, name: "Boston Celtics"));
      listNbaTeam.add(Team(id: 2, name: "Brooklyn Nets"));

      final NbaTeams tNbaTeams = NbaTeams(nbaTeams: listNbaTeam);

      test("Should get data from getNbaTeam use case", () async {
        //arrange
        when(mockGetNbaTeams(any)).thenAnswer((_) async => Right(tNbaTeams));

        //act
        bloc.add(FetchNbaTeams());
        await untilCalled(mockGetNbaTeams(any));

        //assert
        verify(mockGetNbaTeams(NoParams()));
      });

      test(
        'should emit [Loading, Loaded] when data is gotten successfully',
            () async {
          // arrange
          when(mockGetNbaTeams(any))
              .thenAnswer((_) async => Right(tNbaTeams));
          // assert later
          final expected = [
            Empty(),
            Loading(),
            Loaded(nbaTeams: tNbaTeams),
          ];
          expectLater(bloc, emitsInOrder(expected));
          // act
          bloc.add(FetchNbaTeams());
        },
      );

      test(
        "should emit (loading, error) with a proper message when getting data fails",
        () async {
          //arrange
          when(mockGetNbaTeams(any))
              .thenAnswer((_) async => Left(CacheFailure()));

          //assert later
          final expected = [
            Empty(),
            Loading(),
            Error(message: "Failed to fetch data"),
          ];
          expectLater(bloc, emitsInOrder(expected));

          //act
          bloc.add(FetchNbaTeams());
        },
      );
    },
  );
}
