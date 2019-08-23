import 'package:flutter/material.dart';
import 'package:bloc_example/presentation/screens/counter/widgets/counter_scaffold.dart';

class CounterWithGlobalStateScreen extends StatelessWidget {
  static const String routeName = 'counter_with_global_state';

  const CounterWithGlobalStateScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CounterScaffold(title: 'Counter - Global State');
  }
}
