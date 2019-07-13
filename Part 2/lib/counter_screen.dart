import 'package:flutter/material.dart';
import 'action_button.dart';
import 'blocs/counter_bloc.dart';
import 'flutter_bloc/bloc_builder.dart';
import 'flutter_bloc/bloc_provider.dart';

class CounterScreenWithGlobalState extends StatelessWidget {
  const CounterScreenWithGlobalState({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CounterScaffold(title: 'Counter - Global State');
  }
}

class CounterScreenWithLocalState extends StatefulWidget {
  CounterScreenWithLocalState({Key key}) : super(key: key);

  _CounterScreenWithLocalStateState createState() =>
      _CounterScreenWithLocalStateState();
}

class _CounterScreenWithLocalStateState
    extends State<CounterScreenWithLocalState> {
  CounterBloc _counterBloc;

  @override
  void initState() {
    super.initState();
    _counterBloc = CounterBloc();
  }

  @override
  void dispose() {
    _counterBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      bloc: _counterBloc,
      child: CounterScaffold(title: 'Counter - Local State'),
    );
  }
}

class CounterScaffold extends StatelessWidget {
  final String title;

  const CounterScaffold({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: BlocBuilder(
          bloc: counterBloc,
          builder: (BuildContext context, int state) {
            return Text(
              '$state',
              style: TextStyle(
                fontSize: 100,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ActionButton(
              iconData: Icons.add,
              onPressed: () {
                counterBloc.dispatch(CounterEvent.increment);
              },
            ),
            ActionButton(
              iconData: Icons.remove,
              onPressed: () {
                counterBloc.dispatch(CounterEvent.decrement);
              },
            ),
            ActionButton(
              iconData: Icons.replay,
              onPressed: () {
                counterBloc.dispatch(CounterEvent.reset);
              },
            ),
          ],
        ),
      ),
    );
  }
}
