import 'package:hive/hive.dart';
import 'package:quick_editor_v2/utils/log.dart';

import '../abstract/counter.dart';
import '../abstract/counter_item.dart';
part 'counter_item.g.dart';

@HiveType(typeId: 1)
class CounterItemHiveImpl extends CounterItem with HiveObject {
  @override
  @HiveField(0)
  final Counter counter;

  @override
  @HiveField(1)
  final String name;

  CounterItemHiveImpl(this.counter, this.name) : super(counter, name);

  @override
  Future<void> save() async {
    if (isInBox) {
      return super.save();
    } else {
      Log.error("CounterItem isn't in box", toString());
    }
  }

  @override
  Future<void> delete() async {
    if (isInBox) {
      return super.delete();
    } else {
      Log.error("CounterItem isn't in box", toString());
    }
  }

  @override
  CounterItem copyWith({Counter counter, String name}) =>
      CounterItemHiveImpl(counter ?? this.counter, name ?? this.name);

  @override
  String toString() {
    return 'CounterItemHiveImpl{counter: $counter, name: $name}';
  }
}
