import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'blocs/my_bloc_delegate.dart';
import 'blocs/counter_bloc.dart';
import 'blocs/stopwatch_bloc.dart';
// import 'bloc/bloc_supervisor.dart';
// import 'flutter_bloc/bloc_provider.dart';
// import 'flutter_bloc/bloc_provider_tree.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocSupervisor.delegate = MyBlocDelegate();

  runApp(
    BlocProviderTree(
      blocProviders: [
        BlocProvider<CounterBloc>(builder: (context) => CounterBloc()),
        BlocProvider<StopwatchBloc>(builder: (context) => StopwatchBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: HomeScreen(),
      ),
    ),
  );
}
