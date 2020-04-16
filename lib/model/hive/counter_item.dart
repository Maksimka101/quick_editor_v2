import 'package:hive/hive.dart';
import 'package:quick_editor_v2/utils/log.dart';

import '../abstract/counter.dart';
import '../abstract/counter_item.dart';

part 'counter_item.g.dart';

@HiveType(typeId: 1)
class CounterItemHiveImpl extends CounterItem {
  @override
  @HiveField(2)
  final int id;

  @override
  @HiveField(0)
  final Counter counter;

  @override
  @HiveField(1)
  final String name;

  @override
  CounterItemHiveImpl({this.id, this.counter, this.name});

  @override
  CounterItem copyWith({Counter counter, String name, int id}) =>
      CounterItemHiveImpl(
          counter: counter ?? this.counter,
          name: name ?? this.name,
          id: id ?? this.id);

  @override
  String toString() {
    return 'CounterItemHiveImpl{counter: $counter, name: $name}';
  }
}
