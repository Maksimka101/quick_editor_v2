// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TableHiveImplAdapter extends TypeAdapter<TableHiveImpl> {
  @override
  final typeId = 0;

  @override
  TableHiveImpl read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TableHiveImpl(
      fields[0] as String,
      fields[1] as int,
      fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TableHiveImpl obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.countersCount)
      ..writeByte(2)
      ..write(obj.position);
  }
}
