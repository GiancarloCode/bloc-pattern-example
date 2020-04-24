import 'package:flutter/widgets.dart';
import 'package:bloc_example/presentation/screens/home/home_screen.dart';
import 'package:bloc_example/presentation/screens/counter/counter_with_local_state_screen.dart';
import 'package:bloc_example/presentation/screens/counter/counter_with_global_state_screen.dart';
import 'package:bloc_example/presentation/screens/stopwatch/stopwatch_with_local_state_screen.dart';
import 'package:bloc_example/presentation/screens/stopwatch/stopwatch_with_global_state_screen.dart';
import 'package:bloc_example/presentation/screens/preferences/theme_selector_screen.dart';

navigateToHome(BuildContext context) =>
    Navigator.of(context).pushNamed(HomeScreen.routeName);

navigateToCounterWithLocalState(BuildContext context) =>
    Navigator.of(context).pushNamed(CounterWithLocalStateScreen.routeName);

navigateToCounterWithGlobalState(BuildContext context) =>
    Navigator.of(context).pushNamed(CounterWithGlobalStateScreen.routeName);

navigateToStopwatchWithLocalState(BuildContext context) =>
    Navigator.of(context).pushNamed(StopwatchWithLocalStateScreen.routeName);

navigateToStopwatchWithGlobalState(BuildContext context) =>
    Navigator.of(context).pushNamed(StopwatchWithGlobalStateScreen.routeName);

navigateToThemeSelector(BuildContext context) =>
    Navigator.of(context).pushNamed(ThemeSelectorScreen.routeName);
