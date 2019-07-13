import 'bloc_delegate.dart';

class BlocSupervisor {
  BlocDelegate _delegate = BlocDelegate();

  BlocSupervisor._();

  static final BlocSupervisor _instance = BlocSupervisor._();

  static BlocDelegate get delegate => _instance._delegate;

  static set delegate(BlocDelegate d) {
    _instance._delegate = d ?? BlocDelegate();
  }
}
