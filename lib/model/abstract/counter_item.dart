import 'package:quick_editor_v2/model/abstract/counter.dart';

abstract class CounterItem {
  final Counter counter;
  final String name;

  const CounterItem(this.counter, this.name);

  CounterItem copyWith({Counter counter, String name});
}
