import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_example/blocs/my_bloc_delegate.dart';
import 'package:bloc_example/repositories/preferences_repository_impl.dart';
import 'package:bloc_example/blocs/preferences/preferences_bloc.dart';
import 'package:bloc_example/presentation/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  BlocSupervisor.delegate = MyBlocDelegate();

  final preferencesRepository = PreferencesRepositoryImpl();
  final preferencesBloc =
      PreferencesBloc(preferencesRepository: preferencesRepository);

  preferencesBloc.state
      .firstWhere((state) => state is PreferencesLoaded)
      .then((_) => runApp(App(
            preferencesRepository: preferencesRepository,
            preferencesBloc: preferencesBloc,
          )));

  preferencesBloc.dispatch(LoadPreferences());
}
