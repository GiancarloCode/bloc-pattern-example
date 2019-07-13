import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class Transition<Event, State> extends Equatable {
  final State currentState;
  final Event event;
  final State nextState;

  Transition({
    @required this.currentState,
    @required this.event,
    @required this.nextState,
  })  : assert(currentState != null),
        assert(event != null),
        assert(nextState != null),
        super([
          currentState,
          event,
          nextState,
        ]);

  @override
  String toString() =>
      'Transition { currentState: $currentState, event: $event, nextState: $nextState }';
}
