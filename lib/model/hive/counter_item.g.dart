// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CounterItemHiveImplAdapter extends TypeAdapter<CounterItemHiveImpl> {
  @override
  final typeId = 1;

  @override
  CounterItemHiveImpl read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CounterItemHiveImpl(
      fields[0] as Counter,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CounterItemHiveImpl obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.counter)
      ..writeByte(1)
      ..write(obj.name);
  }
}
