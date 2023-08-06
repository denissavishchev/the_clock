import 'package:hive/hive.dart';
import 'package:the_clock/models/alarm_model.dart';
import 'clock_model.dart';

class Boxes {
  static Box<AlarmModel> addAlarmToBase() =>
      Hive.box<AlarmModel>('alarm_page');

  static Box<ClockModel> addClockToBase() =>
      Hive.box<ClockModel>('clock_page');
}