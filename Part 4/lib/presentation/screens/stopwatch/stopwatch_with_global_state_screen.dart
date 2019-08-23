import 'package:flutter/material.dart';
import 'package:bloc_example/presentation/screens/stopwatch/widgets/stopwatch_scaffold.dart';

class StopwatchWithGlobalStateScreen extends StatelessWidget {
  static const String routeName = 'stopwatch_with_global_state';

  const StopwatchWithGlobalStateScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StopwatchScaffold(
      title: 'Stopwatch - Global State',
    );
  }
}
