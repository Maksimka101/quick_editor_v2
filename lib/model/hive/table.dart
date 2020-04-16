import 'package:hive/hive.dart';

import '../abstract/table_item.dart';

part 'table.g.dart';

@HiveType(typeId: 0)
class TableHiveImpl extends Table {
  @override
  @HiveField(3)
  final int id;

  @override
  @HiveField(0)
  final String name;

  @override
  @HiveField(1)
  final int countersCount;

  @override
  @HiveField(2)
  final int position;

  @override
  TableHiveImpl({this.id, this.name, this.countersCount, this.position});

  @override
  Table copyWith({String name, int countersCount, int position, int id}) {
    return TableHiveImpl(
        name: name ?? this.name,
        countersCount: countersCount ?? this.countersCount,
        position: position ?? this.position,
        id: id ?? this.id);
  }
}
