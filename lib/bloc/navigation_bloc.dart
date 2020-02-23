import 'package:flutter/cupertino.dart';
import 'package:quick_editor_v2/utils/log.dart';

class NavigatorBloc {
  final _navigatorKey = GlobalKey<NavigatorState>();
  static NavigatorBloc instance = NavigatorBloc._();

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  NavigatorBloc._();

  void add(NavigatorEvent event) {
    switch (event.runtimeType) {
      case Push:
        final pushEvent = event as Push;
        _navigatorKey.currentState.push(
            CupertinoPageRoute<Widget>(builder: (context) => pushEvent.screen));
        break;
      case Pop:
        final popEvent = event as Pop;
        _navigatorKey.currentState.pop(popEvent);
        break;
      default:
        Log.warning("Navigation bloc uncknown event: ", event.toString());
        break;
    }
  }
}

abstract class NavigatorEvent {}

class Push extends NavigatorEvent {
  final Widget screen;

  Push(this.screen);
}

class Pop extends NavigatorEvent {
  final dynamic value;

  Pop([this.value]);
}
