import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'bloc/bloc_supervisor.dart';
import 'blocs/my_bloc_delegate.dart';
import 'blocs/counter_bloc.dart';
import 'flutter_bloc/bloc_provider.dart';

void main() {
  BlocSupervisor.delegate = MyBlocDelegate();

  final counterBloc = CounterBloc();

  runApp(
    BlocProvider<CounterBloc>(
      bloc: counterBloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: HomeScreen(),
      ),
    ),
  );
}
