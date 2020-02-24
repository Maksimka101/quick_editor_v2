abstract class Table {
  final String name;
  final int countersCount;
  final int position;

  Table(this.name, this.countersCount, this.position);

  /// It should delete old object from the storage
  Table copyWith({String name, int countersCount, int position});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Table && runtimeType == other.runtimeType && name == other.name;

  @override
  int get hashCode => name.hashCode;
}
