import 'dart:async';
import 'package:flutter/widgets.dart';
import '../bloc/bloc.dart';

typedef BlocWidgetListener<S> = void Function(BuildContext context, S state);

class BlocListener<E, S> extends StatefulWidget {
  final Bloc<E, S> bloc;

  final BlocWidgetListener<S> listener;

  final Widget child;

  const BlocListener({
    Key key,
    @required this.bloc,
    @required this.listener,
    this.child,
  })  : assert(bloc != null),
        assert(listener != null),
        super(key: key);

  BlocListener<E, S> copyWith(Widget child) {
    return BlocListener<E, S>(
      key: key,
      bloc: bloc,
      listener: listener,
      child: child,
    );
  }

  _BlocListenerState<E, S> createState() => _BlocListenerState<E, S>();
}

class _BlocListenerState<E, S> extends State<BlocListener<E, S>> {
  StreamSubscription<S> _subscription;

  @override
  void initState() {
    super.initState();
    _subscribe();
  }

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  @override
  void didUpdateWidget(BlocListener<E, S> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.bloc.state != widget.bloc.state) {
      if (_subscription != null) {
        _unsubscribe();
      }
      _subscribe();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _subscribe() {
    if (widget.bloc.state != null) {
      _subscription = widget.bloc.state.listen(
        (S state) {
          widget.listener.call(context, state);
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
