import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

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
