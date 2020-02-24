import 'package:quick_editor_v2/model/abstract/table_item.dart';

abstract class TablesRepository {
	Future<List<Table>> allTables();

	Future<void> createTable(Table table);

	Future<void> addAll(List<Table> newTables);

	Future<void> updateTable(Table table);

	Future<void> removeAll();

	Future<void> deleteTable(Table table);

	Table get emptyTable;
}

class NameExist implements Exception {}
