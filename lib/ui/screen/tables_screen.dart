import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_editor_v2/bloc/navigation_bloc.dart';
import 'package:quick_editor_v2/bloc/tables_bloc.dart';
import 'package:quick_editor_v2/model/utils/warning.dart';
import 'package:quick_editor_v2/repository/abstract/tables_repository.dart';
import 'package:quick_editor_v2/ui/widget/error.dart';
import 'package:quick_editor_v2/ui/widget/fab_scaffold.dart';
import 'package:quick_editor_v2/ui/widget/table/table_settings.dart';
import 'package:quick_editor_v2/ui/widget/table/tables_list.dart';
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
      condition: (_, state) => state is TablesUiState,
      builder: (context, state) {
        switch (state.runtimeType) {
          case TablesInitial:
            return const _TablesLoadingScreen();
            break;
          case TablesLoaded:
            return TablesListScreen(
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

class TablesListScreen extends StatelessWidget {
  final List<ct.Table> tables;
  final _scrollController = ScrollController();

  TablesListScreen({Key key, this.tables}) : super(key: key);

  void _listenForAlert(BuildContext context, TablesState state) {
    switch (state.runtimeType) {
      case TableError:
        final errorState = state as ErrorState;
        NavigatorBloc.instance.add(
          ShowSnackBar(
            context: context,
            snackBar: SnackBar(
              content: Text(errorState.errorMessage),
            ),
          ),
        );
    }
  }

  void _openTableScreen(ct.Table table, BuildContext context) {
    // todo
  }

  void _createTable(BuildContext context) => NavigatorBloc.instance.add(
        ShowBottomSheet(
          context: context,
          child: TableSettings(
            table: RepositoryProvider.of<TablesRepository>(context)
                .newTable
                .copyWith(position: tables.length),
            onUpdate: (newTable) {
              BlocProvider.of<TablesBloc>(context).add(TableCreated(newTable));
            },
          ),
        ),
      );

  void _deleteTable(ct.Table table, BuildContext context) =>
      BlocProvider.of<TablesBloc>(context).add(TableDeleted(table));

  @override
  Widget build(BuildContext c) {
    var context = c;
    return BlocListener<TablesBloc, TablesState>(
      condition: (_, state) => !(state is TablesUiState),
      listener: (_, state) => _listenForAlert(context, state),
      child: FabScaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(App.appName),
        ),
        body: Builder(builder: (scaffoldContext) {
          context = scaffoldContext;
          return TablesList(
            onDelete: (table) => _deleteTable(table, context),
            tables: tables,
            scrollController: _scrollController,
            onTableTapped: (table) => _openTableScreen(table, context),
          );
        }),
        fabChild: Icon(Icons.add),
        onFabTab: () => _createTable(context),
        scrollController: _scrollController,
      ),
    );
  }
}

class _TablesLoadingScreen extends StatelessWidget {
  const _TablesLoadingScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(App.appName),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
