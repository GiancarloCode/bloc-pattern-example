import 'package:bloc_example/models/theme.dart';

abstract class PreferencesRepository {
  Future<void> setTheme(Theme theme);

  Future<Theme> getTheme();
}
