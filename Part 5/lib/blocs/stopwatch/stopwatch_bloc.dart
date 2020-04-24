import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'stopwatch_event.dart';
part 'stopwatch_state.dart';

class StopwatchBloc extends Bloc<StopwatchEvent, StopwatchState> {
  int _elapsedTimeInMilliseconds = 0;

  StreamSubscription _streamPeriodicSubscription;

  @override
  Future<void> close() {
    _streamPeriodicSubscription?.cancel();
    _streamPeriodicSubscription = null;

    return super.close();
  }

  @override
  StopwatchState get initialState => StopwatchState.initial();

  @override
  Stream<StopwatchState> mapEventToState(StopwatchEvent event) async* {
    if (event is StartStopwatch) {
      yield* _mapStartStopwatchToState();
    } else if (event is UpdateStopwatch) {
      yield* _mapUpdateStopwatchToState(event);
    } else if (event is StopStopwatch) {
      yield* _mapStopStopwatchToState();
    } else if (event is ResetStopwatch) {
      yield* _mapResetStopwatchToState();
    }
  }

  Stream<StopwatchState> _mapStartStopwatchToState() async* {
    if (_streamPeriodicSubscription == null) {
      _streamPeriodicSubscription =
          Stream.periodic(Duration(milliseconds: 10)).listen(
        (_) {
          _elapsedTimeInMilliseconds += 10;
          add(
            UpdateStopwatch(
              Duration(milliseconds: _elapsedTimeInMilliseconds),
            ),
          );
        },
      );
    }
  }

  Stream<StopwatchState> _mapUpdateStopwatchToState(
    UpdateStopwatch event,
  ) async* {
    final bool isSpecial = event.time.inMilliseconds % 3000 == 0;

    yield StopwatchState(
      time: event.time,
      isInitial: false,
      isRunning: true,
      isSpecial: isSpecial,
    );
  }

  Stream<StopwatchState> _mapStopStopwatchToState() async* {
    _streamPeriodicSubscription?.cancel();
    _streamPeriodicSubscription = null;

    yield state.copyWith(isRunning: false);
  }

  Stream<StopwatchState> _mapResetStopwatchToState() async* {
    _elapsedTimeInMilliseconds = 0;
    if (!state.isRunning) {
      yield StopwatchState.initial();
    }
  }
}
