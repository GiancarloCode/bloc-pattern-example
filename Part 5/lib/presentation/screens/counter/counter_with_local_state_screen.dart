import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_example/blocs/counter_bloc.dart';
import 'package:bloc_example/presentation/screens/counter/widgets/counter_scaffold.dart';

class CounterWithLocalStateScreen extends StatelessWidget {
  static const String routeName = 'counter_with_local_state';
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      create: (context) => CounterBloc(),
      child: CounterScaffold(title: 'Counter - Local State'),
    );
  }
}
