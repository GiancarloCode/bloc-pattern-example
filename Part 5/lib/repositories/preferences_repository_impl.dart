import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloc_example/repositories/preferences_repository.dart';
import 'package:bloc_example/models/theme.dart';

class PreferencesRepositoryImpl implements PreferencesRepository {
  static const String _themeIndexKey = 'themeIndex';

  Future<void> setTheme(Theme theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeIndexKey, theme.index);
  }

  Future<Theme> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_themeIndexKey);

    if (index != null) {
      return Theme.values[index];
    } else {
      return null;
    }
  }
}
