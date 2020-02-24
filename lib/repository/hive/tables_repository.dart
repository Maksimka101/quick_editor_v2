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
  Future<void> createTable(Table table) async {
    final box = await _getBox();
    if (!box.values.any((element) => element.name == table.name)) {
      await box.add(table);
    } else {
      throw NameExist();
    }
  }

  @override
  Future<void> updateTable(Table table) async {
    final box = await _getBox();
    if (!box.values.any((element) => element.name == table.name)) {
      await box.add(table);
    } else {
      throw NameExist();
    }
  }

  @override
  Future<void> deleteTable(Table table) async {
    await (table as TableHiveImpl).delete();
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
  Table get emptyTable => TableHiveImpl('', 0, -1);

  @override
  Future<void> addAll(List<Table> newTables) async {
    final box = await _getBox();
    await box.addAll(newTables);
  }

  @override
  Future<void> removeAll() async {
    final box = await _getBox();
    await box.deleteAll(box.keys);
  }
}
