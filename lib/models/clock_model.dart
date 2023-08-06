import 'package:hive/hive.dart';
part 'clock_model.g.dart';

@HiveType(typeId: 4)
class ClockModel extends HiveObject{
  @HiveField(0)
  late String zone;
}