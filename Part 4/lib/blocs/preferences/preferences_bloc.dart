import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_example/repositories/preferences_repository.dart';
import 'package:bloc_example/models/theme.dart';
import 'package:bloc_example/blocs/preferences/preferences_event.dart';
import 'package:bloc_example/blocs/preferences/preferences_state.dart';

export 'package:bloc_example/blocs/preferences/preferences_event.dart';
export 'package:bloc_example/blocs/preferences/preferences_state.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  final PreferencesRepository _preferencesRepository;

  PreferencesBloc({@required PreferencesRepository preferencesRepository})
      : assert(preferencesRepository != null),
        _preferencesRepository = preferencesRepository;

  @override
  PreferencesState get initialState => PreferencesNotLoaded();

  @override
  Stream<PreferencesState> mapEventToState(PreferencesEvent event) async* {
    if (event is LoadPreferences) {
      yield* _mapLoadPreferencesToState();
    } else if (event is UpdateTheme) {
      yield* _mapUpdateThemeToState(event);
    }
  }

  Stream<PreferencesState> _mapLoadPreferencesToState() async* {
    final theme = (await _preferencesRepository.getTheme());
    if (theme == null) {
      dispatch(UpdateTheme(Theme.dark));
    } else {
      yield PreferencesLoaded(theme: theme);
    }
  }

  Stream<PreferencesState> _mapUpdateThemeToState(UpdateTheme event) async* {
    _preferencesRepository.setTheme(event.theme);
    yield PreferencesLoaded(theme: event.theme);
  }
}
