import 'package:hive/hive.dart';
part 'clock_model.g.dart';

@HiveType(typeId: 36)
class ClockModel extends HiveObject{
  @HiveField(0)
  late String zone;
  @HiveField(7)
  late String offset;
}