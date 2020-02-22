import 'package:bloc/bloc.dart';
import 'package:quick_editor_v2/utils/log.dart';

class CustomBlocDelegate extends BlocDelegate {
  CustomBlocDelegate();

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    Log.error(error.toString(), stacktrace.toString());
    super.onError(bloc, error, stacktrace);
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    Log.info("Event: ${bloc.toString()} ${event.toString()}");
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    Log.info("State: ${bloc.toString()} ${transition.nextState.toString()}");
    super.onTransition(bloc, transition);
  }
}
