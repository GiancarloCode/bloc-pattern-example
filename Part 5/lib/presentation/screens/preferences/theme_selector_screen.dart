import 'package:flutter/material.dart' hide Theme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_example/models/theme.dart';
import 'package:bloc_example/blocs/preferences/preferences_bloc.dart';

class ThemeSelectorScreen extends StatelessWidget {
  static const String routeName = 'theme_selector';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Theme')),
      body: BlocBuilder<PreferencesBloc, PreferencesState>(
        builder: (context, state) {
          if (state is PreferencesLoaded) {
            return ListView.builder(
              itemCount: Theme.values.length,
              itemBuilder: (context, index) {
                return RadioListTile<Theme>(
                  onChanged: (theme) =>
                      context.bloc<PreferencesBloc>().add(UpdateTheme(theme)),
                  value: Theme.values[index],
                  groupValue: state.theme,
                  title: Text(_themeToString(Theme.values[index])),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  String _themeToString(Theme theme) {
    switch (theme) {
      case Theme.light:
        return 'Light';
      case Theme.dark:
        return 'Dark';
    }
    return null;
  }
}
