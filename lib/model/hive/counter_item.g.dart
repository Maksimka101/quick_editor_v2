// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CounterItemHiveImplAdapter extends TypeAdapter<CounterItemHiveImpl> {
  @override
  CounterItemHiveImpl read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CounterItemHiveImpl(
      id: fields[2] as int,
      counter: fields[0] as Counter,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CounterItemHiveImpl obj) {
    writer
      ..writeByte(3)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(0)
      ..write(obj.counter)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get typeId => 1;
}
