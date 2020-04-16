import 'package:bloc/bloc.dart';
import 'package:quick_editor_v2/model/abstract/table_item.dart';
import 'package:quick_editor_v2/model/utils/warning.dart';
import 'package:quick_editor_v2/repository/abstract/tables_repository.dart';
import 'package:quick_editor_v2/utils/log.dart';

class TablesBloc extends Bloc<TablesEvent, TablesState> {
  final TablesRepository _tablesRepository;

  TablesBloc(this._tablesRepository);

  @override
  TablesState get initialState => TablesInitial();

  @override
  Stream<TablesState> mapEventToState(TablesEvent event) async* {
    switch (event.runtimeType) {
      case LoadTables:
        yield* _mapLoadTablesToState();
        break;
      case TableCreated:
        yield* _mapTableCreatedToState(event as TableCreated);
        break;
      case TableDeleted:
        yield* _mapTableDeletedToState(event as TableDeleted);
        break;
      case TableUpdated:
        yield* _mapTableUpdatedToState(event as TableUpdated);
        break;
      case TablesReordered:
        yield* _mapTablesReorderedToState(event as TablesReordered);
        break;
      default:
        Log.warning("Uncknow event: $event");
        break;
    }
  }

  Stream<TablesState> _mapLoadTablesToState() async* {
    final tables = await _tablesRepository.allTables();
    yield TablesLoaded(tables
      ..sort((first, second) => first.position.compareTo(second.position)));
  }

  Stream<TablesState> _mapTableCreatedToState(TableCreated event) async* {
    await _tablesRepository.save(event.table);
    yield* _mapLoadTablesToState();
  }

  Stream<TablesState> _mapTableDeletedToState(TableDeleted event) async* {
    await _tablesRepository.remove(event.table);
//    yield* _mapLoadTablesToState();
  }

  Stream<TablesState> _mapTableUpdatedToState(TableUpdated event) async* {
    await _tablesRepository.save(event.table);
    yield* _mapLoadTablesToState();
  }

  Stream<TablesState> _mapTablesReorderedToState(TablesReordered event) async* {
    final reordered = await _tablesRepository.reorder(event.reorderedTables);
  }
}

abstract class TablesEvent {}

class LoadTables extends TablesEvent {}

class TableCreated extends TablesEvent {
  final Table table;

  TableCreated(this.table);
}

class TableDeleted extends TablesEvent {
  final Table table;

  TableDeleted(this.table);
}

class TableUpdated extends TablesEvent {
  final Table table;

  TableUpdated(this.table);
}

class TablesReordered extends TablesEvent {
  final List<Table> reorderedTables;

  TablesReordered(this.reorderedTables);
}

abstract class TablesState {}

abstract class TablesUiState extends TablesState {}

class TablesInitial extends TablesUiState {}

class TablesLoaded extends TablesUiState {
  final List<Table> tables;

  TablesLoaded(this.tables);
}

class TableWarning extends WarningState with TablesState {
  TableWarning(String warningMessage) : super(warningMessage);
}

class TableError extends ErrorState with TablesState {
  TableError(String errorMessage) : super(errorMessage);
}
