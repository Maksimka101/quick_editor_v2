import 'package:quick_editor_v2/model/abstract/table_item.dart';
import 'package:quick_editor_v2/model/abstract/counter_item.dart';

abstract class CounterRepository {
  final Table table;

  const CounterRepository(this.table);

  Future<List<CounterItem>> allCounterItems();

  Future<void> createCounterItem(CounterItem item);

  Future<void> updateCounterItem(CounterItem item);

  Future<void> deleteCounterItem(CounterItem item);

  Future<void> closeRepository();
}
