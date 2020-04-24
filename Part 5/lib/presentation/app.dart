import 'package:flutter/material.dart' hide Theme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_example/repositories/preferences_repository.dart';
import 'package:bloc_example/models/theme.dart';
import 'package:bloc_example/blocs/preferences/preferences_bloc.dart';
import 'package:bloc_example/blocs/stopwatch/stopwatch_bloc.dart';
import 'package:bloc_example/blocs/counter_bloc.dart';
import 'package:bloc_example/presentation/screens/home/home_screen.dart';
import 'package:bloc_example/presentation/screens/counter/counter_with_local_state_screen.dart';
import 'package:bloc_example/presentation/screens/counter/counter_with_global_state_screen.dart';
import 'package:bloc_example/presentation/screens/stopwatch/stopwatch_with_local_state_screen.dart';
import 'package:bloc_example/presentation/screens/stopwatch/stopwatch_with_global_state_screen.dart';
import 'package:bloc_example/presentation/screens/preferences/theme_selector_screen.dart';
import 'package:bloc_example/presentation/styles/themes_data.dart';

class App extends StatelessWidget {
  final PreferencesRepository preferencesRepository;
  final PreferencesBloc preferencesBloc;

  const App({
    Key key,
    @required this.preferencesRepository,
    @required this.preferencesBloc,
  })  : assert(preferencesRepository != null),
        assert(preferencesBloc != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PreferencesRepository>.value(
          value: preferencesRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<PreferencesBloc>.value(value: preferencesBloc),
          BlocProvider<CounterBloc>(create: (context) => CounterBloc()),
          BlocProvider<StopwatchBloc>(create: (context) => StopwatchBloc()),
        ],
        child: BlocBuilder<PreferencesBloc, PreferencesState>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: state is PreferencesLoaded
                  ? themesData[state.theme]
                  : themesData[Theme.dark],
              initialRoute: HomeScreen.routeName,
              routes: {
                HomeScreen.routeName: (context) => HomeScreen(),
                CounterWithLocalStateScreen.routeName: (context) =>
                    CounterWithLocalStateScreen(),
                CounterWithGlobalStateScreen.routeName: (context) =>
                    CounterWithGlobalStateScreen(),
                StopwatchWithLocalStateScreen.routeName: (context) =>
                    StopwatchWithLocalStateScreen(),
                StopwatchWithGlobalStateScreen.routeName: (context) =>
                    StopwatchWithGlobalStateScreen(),
                ThemeSelectorScreen.routeName: (context) =>
                    ThemeSelectorScreen(),
              },
            );
          },
        ),
      ),
    );
  }
}
