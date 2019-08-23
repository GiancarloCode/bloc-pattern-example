import 'package:equatable/equatable.dart';

abstract class StopwatchEvent extends Equatable {
  StopwatchEvent([List props = const []]) : super(props);
}

class StartStopwatch extends StopwatchEvent {}

class StopStopwatch extends StopwatchEvent {}

class ResetStopwatch extends StopwatchEvent {}

class UpdateStopwatch extends StopwatchEvent {
  final Duration time;

  UpdateStopwatch(this.time) : super([time]);

  @override
  String toString() =>
      'UpdateStopwatch {timeInMilliseconds: ${time.inMilliseconds}}';
}
