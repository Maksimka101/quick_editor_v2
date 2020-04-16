import 'package:quick_editor_v2/model/abstract/counter.dart';

abstract class CounterItem {
  /// unique identity
  final int id;
  final Counter counter;
  final String name;

  const CounterItem({this.counter, this.name, this.id});

  CounterItem copyWith({Counter counter, String name, int id});
}
