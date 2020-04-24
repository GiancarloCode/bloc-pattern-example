import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_example/blocs/counter_bloc.dart';
import 'package:bloc_example/blocs/stopwatch/stopwatch_bloc.dart';
import 'package:bloc_example/presentation/screens/home/widgets/state_chip.dart';
import 'package:bloc_example/presentation/utils/navigation.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'home';

  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counterBloc = context.bloc<CounterBloc>();
    final stopwatchBloc = context.bloc<StopwatchBloc>();

    return MultiBlocListener(
      listeners: [
        BlocListener<CounterBloc, int>(
          listener: (context, state) {
            if (state == 10) {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  content: Text('Count: $state'),
                ),
              );
            }
          },
        ),
        BlocListener<StopwatchBloc, StopwatchState>(
          listener: (context, state) {
            if (state.time.inMilliseconds == 10000) {
              if (!Navigator.of(context).canPop()) {
                navigateToStopwatchWithGlobalState(context);
              }
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('BLoC example'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.palette),
              onPressed: () => navigateToThemeSelector(context),
            )
          ],
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text('Counter'),
              trailing: StateChip(),
              onTap: () => navigateToCounterWithLocalState(context),
            ),
            ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text('Counter'),
              subtitle: BlocBuilder<CounterBloc, int>(
                builder: (context, state) {
                  return Text('$state');
                },
              ),
              trailing: StateChip(isLocalState: false),
              onTap: () => navigateToCounterWithGlobalState(context),
              onLongPress: () {
                counterBloc.add(CounterEvent.increment);
              },
            ),
            ListTile(
              leading: Icon(Icons.timer),
              title: Text('Stopwatch'),
              trailing: StateChip(),
              onTap: () => navigateToStopwatchWithLocalState(context),
            ),
            ListTile(
              leading: Icon(Icons.timer),
              title: Text('Stopwatch'),
              subtitle: BlocBuilder<StopwatchBloc, StopwatchState>(
                builder: (context, state) {
                  return Text('${state.timeFormated}');
                },
              ),
              trailing: StateChip(isLocalState: false),
              onTap: () => navigateToStopwatchWithGlobalState(context),
              onLongPress: () {
                if (stopwatchBloc.state.isRunning) {
                  stopwatchBloc.add(StopStopwatch());
                } else {
                  stopwatchBloc.add(StartStopwatch());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
