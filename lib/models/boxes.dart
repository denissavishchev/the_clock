import 'package:hive/hive.dart';
import 'package:the_clock/models/alarm_model.dart';

class Boxes {
  static Box<AlarmModel> addAlarmToBase() =>
      Hive.box<AlarmModel>('alarm_page');
}