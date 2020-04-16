import 'package:hive/hive.dart';
import 'package:quick_editor_v2/model/abstract/table_item.dart';
import 'package:quick_editor_v2/model/hive/table.dart';
import 'package:quick_editor_v2/repository/abstract/tables_repository.dart';
import 'package:quick_editor_v2/utils/hive_utils.dart';

class TablesRepositoryHiveImpl extends TablesRepository {
  var _boxOpened = false;

  @override
  Future<List<Table>> allTables() async {
    final box = await _getBox();
    return box.values.toList();
  }

  @override
  Future<void> remove(Table table) async {
    if (!(table is TableHiveImpl)) {
      throw Exception(
          'Table type must be a TableHiveImpl but given is ${table.runtimeType}');
    }
    final box = await _getBox();
    await box.delete(table.id);
  }

  @override
  Future<List<Table>> reorder(List<Table> tables) async {
    if (tables.any((element) => !(element is TableHiveImpl))) {
      throw Exception(
          'Table type must be a TableHiveImpl but given is ${tables[0].runtimeType}');
    }
    final box = await _getBox();
    final unorderedTables = box.values.toList();
    if (unorderedTables.length != tables.length) {
      throw Exception(
          "Lenght of tables in db and incoming tables are not the same");
    }
    for (var i = 0; i < unorderedTables.length; i++) {
      if (unorderedTables[i] != tables[i]) {
        await box.delete(unorderedTables[i].id);
        await box.put(tables[i].id, tables[i]);
      }
    }
    return box.values.toList();
  }

  @override
  Future<Table> save(Table table) async {
    if (!(table is TableHiveImpl)) {
      throw Exception(
          'Table type must be a TableHiveImpl but given is ${table.runtimeType}');
    }
    final box = await _getBox();
    if (table.id == null) {
      final tableId = await box.add(table);
      final tableWithId = table.copyWith(id: tableId);
      await box.put(tableId, tableWithId);
      return tableWithId;
    } else {
      await box.put(table.id, table);
      return table;
    }
  }

  Future<Box<Table>> _getBox() async {
    await HiveUtils.instance.init();
    if (!_boxOpened) {
      await Hive.openBox<Table>(HiveUtils.TABLES_BOX);
      _boxOpened = true;
    }
    return Hive.box(HiveUtils.TABLES_BOX);
  }

  @override
  Table get newTable => TableHiveImpl();
}
