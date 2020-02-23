import 'package:hive/hive.dart';

import '../abstract/counter.dart';

part 'counter.g.dart';

@HiveType(typeId: 2)
class IntCounterHiveImpl extends Counter with HiveObject {
  @HiveField(0)
  var _value = 0;

  IntCounterHiveImpl(this._value);

  @override
  String decrement() => (_value--).toString();

  @override
  String increment() => (_value++).toString();

  @override
  String get value => _value.toString();

  @override
  String toString() {
    return 'IntCounterHiveImpl{_value: $_value}';
  }
}
