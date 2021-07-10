import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nba_app/core/error/failures.dart';
import 'package:nba_app/core/error/usecase/usecase.dart';
import 'package:nba_app/feature/domain/usecases/get_nba_teams.dart';
import 'package:nba_app/feature/presentation/bloc/bloc.dart';

class NbaTeamsBloc extends Bloc<NbaTeamsEvent, NbaTeamsState> {
  final GetNbaTeams getNbaTeams;

  NbaTeamsBloc({@required GetNbaTeams nbaTeams})
      : assert(nbaTeams != null),
        getNbaTeams = nbaTeams;

  @override
  NbaTeamsState get initialState => Empty();

  @override
  Stream<NbaTeamsState> mapEventToState(NbaTeamsEvent event) async* {
    if(event is FetchNbaTeams) {
      yield Loading();

      final failureOrNbaTeams = await getNbaTeams(NoParams());

      yield failureOrNbaTeams.fold(
            (failure) => Error(message: _mapFailureToMessage(failure)),
            (data) => Loaded(nbaTeams: data),
      );
    }
  }

  String _mapFailureToMessage(Failures failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "Server Failure";
      case CacheFailure:
        return "Failed cached data";
      default:
        return 'Unexpected Error';
    }
  }
}
