import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:quick_editor_v2/bloc/navigation_bloc.dart';
import 'package:quick_editor_v2/bloc/tables_bloc.dart';
import 'package:quick_editor_v2/model/abstract/table_item.dart' as ct;
import 'package:quick_editor_v2/ui/widget/table/table_item.dart';
import 'package:quick_editor_v2/ui/widget/table/table_settings.dart';
import 'package:quick_editor_v2/utils/app_settings.dart';
import 'package:snappable/snappable.dart';

class TablesList extends StatefulWidget {
  final List<ct.Table> tables;
  final void Function(ct.Table table) onTableTapped;
  final void Function(ct.Table table) onDelete;
  final ScrollController scrollController;

  const TablesList({
    Key key,
    @required this.tables,
    this.onTableTapped,
    this.scrollController,
    @required this.onDelete,
  }) : super(key: key);

  @override
  _TablesListState createState() => _TablesListState();
}

class _TablesListState extends State<TablesList> {
  final _slideController = SlidableController();
  final _deletingDuration = const Duration(milliseconds: 500);
  ct.Table _tableToDelete;

  void _onReorder(int prevPosition, int currentPosition, BuildContext context) {
    if (prevPosition < currentPosition) {
      // removing the item at oldIndex will shorten the list by 1.
      // ignore: parameter_assignments
      currentPosition--;
    }
    final removed = widget.tables.removeAt(prevPosition);
    widget.tables.insert(currentPosition, removed);

    final tables = widget.tables;
    for (int i = 0; i < tables.length; i++) {
      tables[i] = tables[i].copyWith(position: i);
    }

    setState(() {});
    BlocProvider.of<TablesBloc>(context).add(TablesReordered(tables));
  }

  /// start delete animation
  Future<void> _onDelete(
      ct.Table table, GlobalKey<SnappableState> snapKey) async {
    if (App.settings.useSnapOnDelete) {
      await snapKey.currentState.snap();
      await Future<dynamic>.delayed(snapKey.currentState.widget.duration);
    }
    _tableToDelete = table;
    setState(() {});
    await Future<dynamic>.delayed(_deletingDuration);
  }

  @override
  Widget build(BuildContext context) {
    final tablesList = ReorderableListView(
      onReorder: (prev, current) => _onReorder(prev, current, context),
      children: widget.tables.map<Widget>((table) {
        print(table.toString());
        final snapKye = GlobalKey<SnappableState>();
        return Snappable(
          key: snapKye,
          child: Slidable(
            controller: _slideController,
            key: Key("slidable${table.hashCode}"),
            actionPane: const SlidableDrawerActionPane(),
            actions: <Widget>[
              IconSlideAction(
                  key: Key("slidableDeleteIcon${table.hashCode}"),
                  color: Colors.redAccent,
                  caption: "Delete",
                  icon: Icons.delete,
                  closeOnTap: false,
                  onTap: () => _onDelete(table, snapKye))
            ],
            secondaryActions: <Widget>[
              IconSlideAction(
                key: Key("slidableSettingsIcon${table.hashCode}"),
                color: Colors.green[600],
                caption: "Settings",
                icon: Icons.settings,
//                          foregroundColor: Colors.white,
                onTap: () => NavigatorBloc.instance.add(
                  ShowBottomSheet(
                    context: context,
                    child: TableSettings(
                      table: table,
                      onUpdate: (updatedTable) =>
                          BlocProvider.of<TablesBloc>(context)
                              .add(TableUpdated(updatedTable)),
                    ),
                  ),
                ),
              ),
            ],
            child: CounterTableWidget(
              onDeleteAnimationEnded: () => widget.onDelete(table),
              runDeleteAnimation: table == _tableToDelete,
              key: Key("counterTable${table.hashCode}"),
              table: table,
              onTap: () => widget.onTableTapped(table),
            ),
          ),
        );
      }).toList(),
    );
    _tableToDelete = null;
    if (widget.scrollController != null) {
      return PrimaryScrollController(
        controller: widget.scrollController,
        child: tablesList,
      );
    } else {
      return tablesList;
    }
  }
}
