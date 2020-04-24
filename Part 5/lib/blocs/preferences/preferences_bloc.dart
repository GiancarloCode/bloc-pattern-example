import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_example/repositories/preferences_repository.dart';
import 'package:bloc_example/models/theme.dart';

part 'preferences_event.dart';
part 'preferences_state.dart';

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
      add(UpdateTheme(Theme.dark));
    } else {
      yield PreferencesLoaded(theme: theme);
    }
  }

  Stream<PreferencesState> _mapUpdateThemeToState(UpdateTheme event) async* {
    _preferencesRepository.setTheme(event.theme);
    yield PreferencesLoaded(theme: event.theme);
  }
}
