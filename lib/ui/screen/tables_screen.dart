import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:quick_editor_v2/bloc/tables_bloc.dart';
import 'package:quick_editor_v2/repository/abstract/tables_repository.dart';
import 'package:quick_editor_v2/ui/widget/error.dart';
import 'package:quick_editor_v2/ui/widget/fab_scaffold.dart';
import 'package:quick_editor_v2/ui/widget/table/table_item.dart';
import 'package:quick_editor_v2/ui/widget/table/table_settings.dart';
import 'package:quick_editor_v2/utils/app_settings.dart';
import 'package:quick_editor_v2/utils/log.dart';
import 'package:quick_editor_v2/model/abstract/table_item.dart' as ct;

class TablesScreen extends StatefulWidget {
  @override
  _TablesScreenState createState() => _TablesScreenState();
}

class _TablesScreenState extends State<TablesScreen> {
  @override
  void initState() {
    BlocProvider.of<TablesBloc>(context).add(LoadTables());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TablesBloc, TablesState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case TablesInitial:
            return const _TablesLoadingScreen();
            break;
          case TablesLoaded:
            return TablesList(
              tables: (state as TablesLoaded).tables,
            );
          default:
            Log.warning("Uncknow state: $state");
            return const ErrorMessage();
            break;
        }
      },
    );
  }
}

class TablesList extends StatelessWidget {
  final List<ct.Table> tables;
  final _scrollController = ScrollController();

  TablesList({Key key, this.tables}) : super(key: key);

  void _onReorder(int prev, int current, BuildContext context) {
    final prevTable = tables[prev];
    tables[prev] = tables[current].copyWith(position: current);
    tables[current] = prevTable.copyWith(position: prev);
    BlocProvider.of<TablesBloc>(context)
        .add(TablesReordered(tables[current], tables[prev]));
  }

  void _openTableScreen(ct.Table table, BuildContext context) {
    // todo
  }

  void _createTable(BuildContext context) => showTableSettingsBottomSheet(
          context,
          RepositoryProvider.of<TablesRepository>(context)
              .emptyTable
              .copyWith(position: tables.length), (newTable) {
        BlocProvider.of<TablesBloc>(context).add(TableCreated(newTable));
      });

  @override
  Widget build(BuildContext c) {
    var context = c;
    return FabScaffold(
      appBar: AppBar(
        title: Text(AppSettings.appName),
      ),
      body: Builder(builder: (c) {
        context = c;
        return PrimaryScrollController(
          controller: _scrollController,
          child: ReorderableListView(
            onReorder: (prev, current) => _onReorder(prev, current, context),
            children: tables
                .map((table) => Slidable(
              key: Key(table.hashCode.toString()),
                      actionPane: const SlidableDrawerActionPane(),
                      actions: <Widget>[
                        IconSlideAction(
                          caption: "Delete",
                          icon: Icons.delete,
                          onTap: () => BlocProvider.of<TablesBloc>(context)
                              .add(TableDeleted(table)),
                        )
                      ],
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: "Settings",
                          icon: Icons.settings,
                          onTap: () => showTableSettingsBottomSheet(
                              context,
                              table,
                              (updatedTable) =>
                                  BlocProvider.of<TablesBloc>(context)
                                      .add(TableUpdated(updatedTable))),
                        )
                      ],
                      child: CounterTableWidget(
                        table: table,
                        onTap: () => _openTableScreen(table, context),
                      ),
                    ))
                .toList(),
          ),
        );
      }),
      fabChild: Icon(Icons.add),
      onFabTab: () => _createTable(context),
      scrollController: _scrollController,
    );
  }
}

class _TablesLoadingScreen extends StatelessWidget {
  const _TablesLoadingScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppSettings.appName),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
