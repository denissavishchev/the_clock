// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlarmModelAdapter extends TypeAdapter<AlarmModel> {
  @override
  final int typeId = 0;

  @override
  AlarmModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlarmModel()
      ..hour = fields[0] as int
      ..minute = fields[1] as int
      ..ringtone = fields[2] as String
      ..repeat = fields[3] as String
      ..days = (fields[4] as Map).cast<dynamic, dynamic>()
      ..deleteAfter = fields[5] as bool
      ..label = fields[6] as String
      ..isActive = fields[7] as bool;
  }

  @override
  void write(BinaryWriter writer, AlarmModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.hour)
      ..writeByte(1)
      ..write(obj.minute)
      ..writeByte(2)
      ..write(obj.ringtone)
      ..writeByte(3)
      ..write(obj.repeat)
      ..writeByte(4)
      ..write(obj.days)
      ..writeByte(5)
      ..write(obj.deleteAfter)
      ..writeByte(6)
      ..write(obj.label)
      ..writeByte(7)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlarmModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
