import 'dart:async';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
// import '../bloc/bloc.dart';

import 'package:bloc/bloc.dart';

abstract class StopwatchEvent extends Equatable {
  StopwatchEvent([List props = const []]) : super(props);
}

class StartStopwatch extends StopwatchEvent {
  @override
  String toString() => 'StartStopwatch';
}

class StopStopwatch extends StopwatchEvent {
  @override
  String toString() => 'StopStopwatch';
}

class ResetStopwatch extends StopwatchEvent {
  @override
  String toString() => 'ResetStopwatch';
}

class UpdateStopwatch extends StopwatchEvent {
  final Duration time;

  UpdateStopwatch(this.time) : super([time]);

  @override
  String toString() =>
      'UpdateStopwatch {timeInMilliseconds: ${time.inMilliseconds}}';
}

class StopwatchState extends Equatable {
  final Duration time;
  final bool isInitial;
  final bool isRunning;
  final bool isSpecial;

  StopwatchState({
    @required this.time,
    @required this.isInitial,
    @required this.isRunning,
    @required this.isSpecial,
  }) : super([time, isInitial, isRunning, isSpecial]);

  factory StopwatchState.initial() {
    return StopwatchState(
      time: Duration(milliseconds: 0),
      isInitial: true,
      isRunning: false,
      isSpecial: false,
    );
  }

  int get minutes => time.inMinutes.remainder(60);
  int get seconds => time.inSeconds.remainder(60);
  int get hundredths => (time.inMilliseconds / 10).floor().remainder(100);

  String get timeFormated {
    String toTwoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    return '${toTwoDigits(minutes)}:${toTwoDigits(seconds)}.${toTwoDigits(hundredths)}';
  }

  StopwatchState copyWith({
    Duration time,
    bool isInitial,
    bool isRunning,
    bool isSpecial,
  }) {
    return StopwatchState(
      time: time ?? this.time,
      isInitial: isInitial ?? this.isInitial,
      isRunning: isRunning ?? this.isRunning,
      isSpecial: isSpecial ?? this.isSpecial,
    );
  }

  @override
  String toString() {
    return 'StopwatchState { timeFormated: $timeFormated, isInitial: $isInitial, isRunning: $isRunning, isSpecial: $isSpecial }';
  }
}

class StopwatchBloc extends Bloc<StopwatchEvent, StopwatchState> {
  int _elapsedTimeInMilliseconds = 0;

  StreamSubscription _streamPeriodicSubscription;

  @override
  void dispose() {
    _streamPeriodicSubscription?.cancel();
    _streamPeriodicSubscription = null;

    super.dispose();
  }

  @override
  StopwatchState get initialState => StopwatchState.initial();

  @override
  Stream<StopwatchState> mapEventToState(StopwatchEvent event) async* {
    if (event is StartStopwatch) {
      if (_streamPeriodicSubscription == null) {
        _streamPeriodicSubscription =
            Stream.periodic(Duration(milliseconds: 10)).listen(
          (_) {
            _elapsedTimeInMilliseconds += 10;
            dispatch(
              UpdateStopwatch(
                Duration(milliseconds: _elapsedTimeInMilliseconds),
              ),
            );
          },
        );
      }
    } else if (event is UpdateStopwatch) {
      final bool isSpecial = event.time.inMilliseconds % 3000 == 0;

      yield StopwatchState(
        time: event.time,
        isInitial: false,
        isRunning: true,
        isSpecial: isSpecial,
      );
    } else if (event is StopStopwatch) {
      _streamPeriodicSubscription?.cancel();
      _streamPeriodicSubscription = null;

      yield currentState.copyWith(isRunning: false);
    } else if (event is ResetStopwatch) {
      _elapsedTimeInMilliseconds = 0;
      if (!currentState.isRunning) {
        yield StopwatchState.initial();
      }
    }
  }
}
