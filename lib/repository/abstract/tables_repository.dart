import 'package:quick_editor_v2/model/abstract/table_item.dart';

abstract class TablesRepository {

	/// just return all tables
	Future<List<Table>> allTables();

	/// save table and return it with id
	Future<Table> save(Table table);

	/// remove table
	Future<void> remove(Table table);

	/// reorder ALL the tables and return tables maybe with new ids
	Future<List<Table>> reorder(List<Table> tables);

	Table get newTable;
}
