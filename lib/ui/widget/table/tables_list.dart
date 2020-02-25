import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:quick_editor_v2/bloc/navigation_bloc.dart';
import 'package:quick_editor_v2/bloc/tables_bloc.dart';
import 'package:quick_editor_v2/model/abstract/table_item.dart' as ct;
import 'package:quick_editor_v2/ui/widget/table/table_item.dart';
import 'package:quick_editor_v2/ui/widget/table/table_settings.dart';

class TablesList extends StatefulWidget {
  final List<ct.Table> tables;
  final void Function(ct.Table table) openTableScreen;
  final ScrollController scrollController;

  const TablesList({
    Key key,
    @required this.tables,
    this.openTableScreen,
    this.scrollController,
  }) : super(key: key);
  @override
  _TablesListState createState() => _TablesListState();
}

class _TablesListState extends State<TablesList> {
  final _slideController = SlidableController();

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

  @override
  Widget build(BuildContext context) {
    final tablesList = ReorderableListView(
      onReorder: (prev, current) => _onReorder(prev, current, context),
      children: widget.tables
          .map<Widget>((table) => Slidable(
                controller: _slideController,
                key: Key(table.hashCode.toString()),
                actionPane: const SlidableDrawerActionPane(),
                actions: <Widget>[
                  IconSlideAction(
                    color: Colors.redAccent,
                    caption: "Delete",
                    icon: Icons.delete,
                    onTap: () => BlocProvider.of<TablesBloc>(context)
                        .add(TableDeleted(table)),
                  )
                ],
                secondaryActions: <Widget>[
                  IconSlideAction(
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
                  table: table,
                  onTap: () => widget.openTableScreen(table),
                ),
              ))
          .toList(),
    );
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
