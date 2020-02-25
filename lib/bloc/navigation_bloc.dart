import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      case ShowBottomSheet:
        final bottomSheetsEvent = event as ShowBottomSheet;
        if (bottomSheetsEvent.context != null) {
          Scaffold.of(bottomSheetsEvent.context)
              .showBottomSheet<Widget>((_) => bottomSheetsEvent.child);
        } else if (bottomSheetsEvent.scaffoldKey != null) {
          bottomSheetsEvent.scaffoldKey.currentState
              ?.showBottomSheet<Widget>((context) => bottomSheetsEvent.child);
        } else {
          Log.warning("No scaffold key and context was provided "
              "in show bottom sheet event");
        }
        break;
      case ShowSnackBar:
        final snackEvent = event as ShowSnackBar;
        if (snackEvent.context != null) {
          Scaffold.of(snackEvent.context).showSnackBar(snackEvent.snackBar);
        } else if (snackEvent.scaffoldKey != null) {
          snackEvent.scaffoldKey.currentState
              ?.showSnackBar(snackEvent.snackBar);
        } else {
          Log.warning(
              "No scaffold key and context was provided in show snck event");
        }
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

class ShowBottomSheet extends NavigatorEvent {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final BuildContext context;
  final Widget child;

  ShowBottomSheet({this.child, this.context, this.scaffoldKey})
      : assert(scaffoldKey == null || context == null);
}

class ShowSnackBar extends NavigatorEvent {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final BuildContext context;
  final SnackBar snackBar;

  ShowSnackBar({this.scaffoldKey, this.context, this.snackBar})
      : assert(scaffoldKey == null || context == null);
}

class Pop extends NavigatorEvent {
  final dynamic value;

  Pop([this.value]);
}
