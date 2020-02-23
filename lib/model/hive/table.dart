import 'package:hive/hive.dart';

import '../abstract/table_item.dart';
part 'table.g.dart';

@HiveType(typeId: 0)
class TableHiveImpl extends Table with HiveObject {
  @override
  @HiveField(0)
  final String name;

  @override
  @HiveField(1)
  final int countersCount;

  TableHiveImpl(this.name, this.countersCount) : super(name, countersCount);

  @override
  Table copyWith({String name, int countersCount}) =>
      TableHiveImpl(name ?? this.name, countersCount ?? this.countersCount);
}
