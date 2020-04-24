import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_example/blocs/stopwatch/stopwatch_bloc.dart';
import 'package:bloc_example/presentation/screens/stopwatch/widgets/stopwatch_scaffold.dart';

class StopwatchWithLocalStateScreen extends StatelessWidget {
  static const String routeName = 'stopwatch_with_local_state';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StopwatchBloc(),
      child: StopwatchScaffold(
        title: 'Stopwatch - Local State',
      ),
    );
  }
}
