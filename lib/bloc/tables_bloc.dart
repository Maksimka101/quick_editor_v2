import 'package:bloc/bloc.dart';
import 'package:quick_editor_v2/utils/log.dart';

class TablesBloc extends Bloc<TablesEvent, TablesState> {
  @override
  TablesState get initialState => TablesInitial();

  @override
  Stream<TablesState> mapEventToState(TablesEvent event) async* {
    switch (event.runtimeType) {
      case LoadTables:
        yield* _mapLoadTablesToState();
        break;
      default:
        Log.warning("Uncknow event: $event");
        break;
    }
  }

  Stream<TablesState> _mapLoadTablesToState() async* {
    //
  }
}

abstract class TablesEvent {}

class LoadTables extends TablesEvent {}

abstract class TablesState {}

class TablesInitial extends TablesState {}
