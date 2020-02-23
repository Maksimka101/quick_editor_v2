import 'package:flutter/material.dart';
import 'package:quick_editor_v2/model/abstract/table_item.dart' as ct;

class CounterTableWidget extends StatelessWidget {
  final ct.Table table;
  final void Function() onTap;

  const CounterTableWidget({Key key, @required this.table, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(table.name),
    );
  }
}
