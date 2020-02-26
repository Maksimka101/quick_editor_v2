import 'package:hive/hive.dart';

import '../abstract/table_item.dart';
part 'table.g.dart';

// todo: remove hive object dependency
@HiveType(typeId: 0)
class TableHiveImpl extends Table with HiveObject {
  @override
  @HiveField(0)
  final String name;

  @override
  @HiveField(1)
  final int countersCount;

  @override
  @HiveField(2)
  final int position;

  TableHiveImpl(this.name, this.countersCount, this.position)
      : super(name, countersCount, position);

  @override
  Table copyWith({String name, int countersCount, int position}) {
    if (isInBox) {
      this.delete();
    }
    return TableHiveImpl(name ?? this.name, countersCount ?? this.countersCount,
        position ?? this.position);
  }
}
