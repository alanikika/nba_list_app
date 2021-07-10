import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:nba_app/feature/data/datasources/nba_teams_remote_data_source.dart';
import 'package:nba_app/feature/data/models/nba_teams_model.dart';

import '../../../fixtures/fixtures_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  NbaTeamsRemoteDataSourceImpl remoteDataSourceImpl;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    remoteDataSourceImpl = NbaTeamsRemoteDataSourceImpl(client: mockHttpClient);
  });

  group(
    "getNbaTeams",
    () {
      final tNbaTeamsModel = NbaTeamsModel.fromJson(
        json.decode(fixture("teams.json")),
      );

      test("should perform a GET request method", () {
        //arrange
        when(mockHttpClient.get(any, headers: anyNamed("headers"))).thenAnswer(
          (_) async => http.Response(fixture("teams.json"), 200),
        );

        //act
        remoteDataSourceImpl.getNbaTeams();

        //assert
        verify(mockHttpClient.get(
          "http://localhost:3000/channel",
          headers: {'Content-Type': 'application/json'},
        ));
      });

      test(
        "should return NbaTeams entity when the response is 200",
        () async {
          //arrange
          when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
              (_) async => http.Response(fixture("teams.json"), 200),
          );

          //act
          final result = await remoteDataSourceImpl.getNbaTeams();

          //assert
          expect(result, equals(tNbaTeamsModel));
        },
      );

      // test(
      //   "should throw a server exception when the response code is 404",
      //     () async {
      //     //arrange
      //       when(mockHttpClient.get(any, headers: anyNamed("headers"))).thenAnswer(
      //           (_) async => http.Response("Something went wrong", 404);
      //       );
      //
      //       //act
      //       final call = remoteDataSourceImpl.getNbaTeams();
      //
      //       //assert
      //       expect(() => call(), throwsA(TypeMatcher<ServerException>()))
      //     }
      // );
    },
  );
}
