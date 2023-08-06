import 'package:flutter/material.dart';
import 'models/alarm_model.dart';
import 'models/clock_model.dart';
import 'pages/main_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AlarmModelAdapter());
  Hive.registerAdapter(ClockModelAdapter());
  await Hive.openBox<AlarmModel>('alarm_page');
  await Hive.openBox<ClockModel>('clock_page');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
        home: MainPage());
  }
}

