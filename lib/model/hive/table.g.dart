// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TableHiveImplAdapter extends TypeAdapter<TableHiveImpl> {
  @override
  TableHiveImpl read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TableHiveImpl(
      id: fields[3] as int,
      name: fields[0] as String,
      countersCount: fields[1] as int,
      position: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TableHiveImpl obj) {
    writer
      ..writeByte(4)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.countersCount)
      ..writeByte(2)
      ..write(obj.position);
  }

  @override
  int get typeId => 0;
}
