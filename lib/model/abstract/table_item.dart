abstract class Table {
  final String name;
  final int countersCount;

  Table(this.name, this.countersCount);

  Table copyWith({String name, int countersCount});
}
