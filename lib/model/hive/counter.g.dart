// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IntCounterHiveImplAdapter extends TypeAdapter<IntCounterHiveImpl> {
  @override
  IntCounterHiveImpl read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IntCounterHiveImpl(
      fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, IntCounterHiveImpl obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj._value);
  }

  @override
  int get typeId => 2;
}
