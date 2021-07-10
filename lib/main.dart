import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nba_app/feature/domain/entities/team.dart';
import 'package:nba_app/feature/presentation/bloc/bloc.dart';
import 'injection_container.dart' as di;

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print('onEvent: $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition: $transition');
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print('onError: $error');
  }
}

void main() async {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NbaTeamsBloc>(
          create: (context) => di.sl<NbaTeamsBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Nba Team List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Nba Teams'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NbaTeamsBloc _nbaTeamsBloc;

  @override
  void initState() {
    _nbaTeamsBloc = BlocProvider.of<NbaTeamsBloc>(context);
    _nbaTeamsBloc.add(FetchNbaTeams());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(16.0),
              child: Text("2 Teams Subscribed"),
            ),
            BlocBuilder<NbaTeamsBloc, NbaTeamsState>(
              builder: (context, state) {
                if (state is Empty) {
                  return Text("NO DATA");
                } else if (state is Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is Error) {
                  return Text("error");
                } else if (state is Loaded) {
                  return ListView.builder(
                    itemCount: state.nbaTeams.nbaTeams.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildItemCard(state.nbaTeams.nbaTeams[index]);
                    },
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCard(Team team) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300],
            offset: const Offset(0.0, 4.0),
            blurRadius: 10.0,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              team.name,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Text(
              "Subscribe",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
