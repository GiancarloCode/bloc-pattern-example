import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_example/models/theme.dart';

abstract class PreferencesState extends Equatable {
  PreferencesState([List props = const []]) : super(props);
}

class PreferencesNotLoaded extends PreferencesState {}

class PreferencesLoaded extends PreferencesState {
  final Theme theme;

  PreferencesLoaded({@required this.theme}) : super([theme]);

  @override
  String toString() => '$runtimeType { $theme }';
}
