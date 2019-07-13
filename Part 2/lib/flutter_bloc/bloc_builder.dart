import 'dart:async';
import 'package:flutter/widgets.dart';
import '../bloc/bloc.dart';

typedef BlocWidgetBuilder<S> = Widget Function(BuildContext context, S state);

typedef BlocBuilderCondition<S> = bool Function(S previous, S current);

class BlocBuilder<E, S> extends StatefulWidget {
  final Bloc<E, S> bloc;

  final BlocBuilderCondition<S> condition;

  final BlocWidgetBuilder<S> builder;

  const BlocBuilder({
    Key key,
    @required this.bloc,
    @required this.builder,
    this.condition,
  })  : assert(bloc != null),
        assert(builder != null),
        super(key: key);

  _BlocBuilderState<E, S> createState() => _BlocBuilderState<E, S>();
}

class _BlocBuilderState<E, S> extends State<BlocBuilder<E, S>> {
  StreamSubscription<S> _subscription;
  S _previousState;
  S _state;

  @override
  void initState() {
    super.initState();
    _previousState = widget.bloc.currentState;
    _state = widget.bloc.currentState;
    _subscribe();
  }

  @override
  void didUpdateWidget(BlocBuilder<E, S> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.bloc.state != widget.bloc.state) {
      if (_subscription != null) {
        _unsubscribe();
        _previousState = widget.bloc.currentState;
        _state = widget.bloc.currentState;
      }
      _subscribe();
    }
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _state);

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  void _subscribe() {
    if (widget.bloc.state != null) {
      _subscription = widget.bloc.state.skip(1).listen(
        (S state) {
          if (widget.condition?.call(_previousState, state) ?? true) {
            setState(() {
              _state = state;
            });
          }
          _previousState = state;
        },
      );
    }
  }

  void _unsubscribe() {
    if (_subscription != null) {
      _subscription.cancel();
      _subscription = null;
    }
  }
}
