import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nba_app/core/error/usecase/usecase.dart';
import 'package:nba_app/feature/domain/entities/nba_teams.dart';
import 'package:nba_app/feature/domain/entities/team.dart';
import 'package:nba_app/feature/domain/repositories/nba_teams_repository.dart';
import 'package:nba_app/feature/domain/usecases/get_nba_teams.dart';

class MockNbaTeamsRepository extends Mock implements NbaTeamsRepository {}

void main() {
  GetNbaTeams useCases;
  MockNbaTeamsRepository mockNbaTeamsRepository;

  setUp(() {
    mockNbaTeamsRepository = MockNbaTeamsRepository();
    useCases = GetNbaTeams(nbaTeamsRepository: mockNbaTeamsRepository);
  });

  List<Team> teams = List<Team>();
  teams.add(Team(id: 1, name: "Boston Celtics"));
  teams.add(Team(id: 2, name: "Brooklyn Nets"));
  teams.add(Team(id: 3, name: "Phoenix Suns"));
  teams.add(Team(id: 4, name: "Los Angeles Lakers"));
  teams.add(Team(id: 5, name: "Dallas Mavericks"));

  final nbaTeams = NbaTeams(nbaTeams: teams);

  test(
    "Should get list nba teams from the repository",
    () async {
      //arrange
      when(mockNbaTeamsRepository.getNbaTeams())
          .thenAnswer((_) async => Right(nbaTeams));
      //act
      final result = await useCases(NoParams());

      //assert
      expect(result, Right(nbaTeams));
      verify(mockNbaTeamsRepository.getNbaTeams());
      verifyNoMoreInteractions(mockNbaTeamsRepository);
    },
  );
}
