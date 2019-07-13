import '../bloc/bloc.dart';
import '../bloc/transition.dart';

enum CounterEvent { increment, decrement, reset }

class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  int get initialState => 0;

  @override
  void onEvent(CounterEvent event) {
    // print('bloc: ${this.runtimeType}, event: $event');
  }

  @override
  void onTransition(Transition<CounterEvent, int> transition) {
    // print('bloc: ${this.runtimeType}, transition: $transition');
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    // print('bloc: ${this.runtimeType}, error: $error, stacktrace: $stacktrace');
  }

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    if (event == CounterEvent.increment) {
      yield currentState + 1;
    } else if (event == CounterEvent.decrement) {
      yield currentState - 1;
    } else if (event == CounterEvent.reset) {
      yield 0;
      // throw Exception('My exception');
    }
  }
}
