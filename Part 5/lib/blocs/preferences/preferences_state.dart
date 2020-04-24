part of 'preferences_bloc.dart';

abstract class PreferencesState extends Equatable {}

class PreferencesNotLoaded extends PreferencesState {
  @override
  List<Object> get props => [];
}

class PreferencesLoaded extends PreferencesState {
  final Theme theme;

  PreferencesLoaded({@required this.theme});

  @override
  List<Object> get props => [theme];

  @override
  String toString() => '$runtimeType { $theme }';
}
