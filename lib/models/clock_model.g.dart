// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clock_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClockModelAdapter extends TypeAdapter<ClockModel> {
  @override
  final int typeId = 36;

  @override
  ClockModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClockModel()
      ..zone = fields[0] as String
      ..offset = fields[7] as String;
  }

  @override
  void write(BinaryWriter writer, ClockModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.zone)
      ..writeByte(7)
      ..write(obj.offset);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClockModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
