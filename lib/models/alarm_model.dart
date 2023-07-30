import 'package:hive/hive.dart';
part 'alarm_model.g.dart';

@HiveType(typeId: 0)
class AlarmModel extends HiveObject{
  @HiveField(0)
  late int hour;
  @HiveField(1)
  late int minute;
  @HiveField(2)
  late String ringtone;
  @HiveField(3)
  late String repeat;
  @HiveField(4)
  late Map days;
  @HiveField(5)
  late bool deleteAfter = false;
  @HiveField(6)
  late String label;
}