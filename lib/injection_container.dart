import 'package:get_it/get_it.dart';
import 'package:nba_app/feature/data/datasources/nba_teams_remote_data_source.dart';
import 'package:nba_app/feature/data/repositories/nba_teams_repository_impl.dart';
import 'package:nba_app/feature/domain/usecases/get_nba_teams.dart';
import 'package:nba_app/feature/presentation/bloc/bloc.dart';
import 'package:nba_app/feature/domain/repositories/nba_teams_repository.dart';
import 'package:http/http.dart' as http;
import 'package:nba_app/core/platform/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => NbaTeamsBloc(nbaTeams: sl()),
  );

  //use case
  sl.registerLazySingleton(() => GetNbaTeams(nbaTeamsRepository: sl()));

  //repository
  sl.registerLazySingleton<NbaTeamsRepository>(
    () => NbaTeamsRepositoryImpl(
      remoteDataSource: sl(),
      netWorkInfo: sl(),
    ),
  );

  //data source
  sl.registerLazySingleton<NbaTeamsRemoteDataSource>(
    () => NbaTeamsRemoteDataSourceImpl(client: sl()),
  );

  //core
  sl.registerLazySingleton<NetWorkInfo>(() => NetWorkInfoImpl());

  //external
  sl.registerLazySingleton(() => http.Client());
}
