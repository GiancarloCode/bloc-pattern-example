part of 'preferences_bloc.dart';

abstract class PreferencesEvent extends Equatable {}

class LoadPreferences extends PreferencesEvent {
  @override
  List<Object> get props => [];
}

class UpdateTheme extends PreferencesEvent {
  final Theme theme;

  UpdateTheme(this.theme);

  @override
  List<Object> get props => [theme];

  @override
  String toString() => '$runtimeType { $theme }';
}
