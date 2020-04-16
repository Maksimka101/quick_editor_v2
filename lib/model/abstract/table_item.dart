abstract class Table {
  /// unique identity of this table
  final int id;
  final String name;
  final int countersCount;
  final int position;

  Table({this.name, this.countersCount, this.position, this.id});

  Table copyWith({String name, int countersCount, int position, int id});

  @override
  String toString() {
    return 'Table{id: $id, name: $name, countersCount: $countersCount, position: $position}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Table &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          countersCount == other.countersCount &&
          position == other.position;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ countersCount.hashCode ^ position.hashCode;
}
