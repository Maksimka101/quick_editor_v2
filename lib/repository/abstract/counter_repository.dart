import 'package:quick_editor_v2/model/abstract/table_item.dart';
import 'package:quick_editor_v2/model/abstract/counter_item.dart';

abstract class CounterRepository {
  final Table table;

  const CounterRepository(this.table);

  Future<List<CounterItem>> allCounterItems();

  /// save counter item and return a copy of it with id
  Future<CounterItem> saveCounterItem(CounterItem item);

  /// just delete a counter item
  Future<void> deleteCounterItem(CounterItem item);

  /// free all resources
  /// close all connections
  /// save the world
  Future<void> dispose();
}
