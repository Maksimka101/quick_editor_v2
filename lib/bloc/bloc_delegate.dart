import 'package:bloc/bloc.dart';
import 'package:quick_editor_v2/utils/log.dart';

class CustomBlocDelegate extends BlocDelegate {
  final Log _log;

  CustomBlocDelegate(this._log);

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    _log.error(error.toString(), stacktrace.toString());
    super.onError(bloc, error, stacktrace);
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    _log.info("Event: ${bloc.toString()} ${event.toString()}");
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    _log.info("State: ${bloc.toString()} ${transition.nextState.toString()}");
    super.onTransition(bloc, transition);
  }
}
