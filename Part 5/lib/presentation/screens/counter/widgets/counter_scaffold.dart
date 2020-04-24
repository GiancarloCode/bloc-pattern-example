import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_example/blocs/counter_bloc.dart';
import 'package:bloc_example/presentation/widgets/widgets.dart';

class CounterScaffold extends StatelessWidget {
  final String title;

  const CounterScaffold({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counterBloc = context.bloc<CounterBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: BlocBuilder<CounterBloc, int>(
          builder: (context, state) {
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
                counterBloc.add(CounterEvent.increment);
              },
            ),
            ActionButton(
              iconData: Icons.remove,
              onPressed: () {
                counterBloc.add(CounterEvent.decrement);
              },
            ),
            ActionButton(
              iconData: Icons.replay,
              onPressed: () {
                counterBloc.add(CounterEvent.reset);
              },
            ),
          ],
        ),
      ),
    );
  }
}
