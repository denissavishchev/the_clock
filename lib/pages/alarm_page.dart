import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_clock/models/alarm_model.dart';
import 'package:the_clock/pages/add_alarm_page.dart';
import '../models/boxes.dart';
import '../widgets/neu_rect_widget.dart';
import '../widgets/neu_round_widget.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  bool _value = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffe9f1f9),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NeuRoundWidget(
                      onPress: () {},
                      size: 50,
                      padding: 14,
                      child: Image.asset('assets/images/gear.png')),
                  NeuRoundWidget(
                      onPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AddAlarmPage()));
                      },
                      size: 50,
                      padding: 14,
                      child: Image.asset('assets/images/add.png')),
                ],
              ),
            ),
            ValueListenableBuilder<Box<AlarmModel>>(
              valueListenable: Boxes.addAlarmToBase().listenable(),
              builder: (context, box, _) {
                final alarms = box.values.toList().cast<AlarmModel>();
                return Container(
                  height: size.height * 0.72,
                  color: const Color(0xffe9f1f9),
                  child: ScrollConfiguration(
                    behavior: const ScrollBehavior().copyWith(overscroll: false),
                    child: ListView.builder(
                        itemCount: alarms.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 24.0),
                            child: NeuRectWidget(
                              padding: 12,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(alarms[index].hour.toString(),
                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                  ),
                                  Text(alarms[index].minute.toString(),
                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(16)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.white,
                                              blurRadius: 10,
                                              offset: Offset(-5, -5)),
                                          BoxShadow(
                                              color: Color(0xFFc9d7e6),
                                              blurRadius: 10,
                                              offset: Offset(5, 5)),
                                        ]),
                                    child: CupertinoSwitch(
                                        trackColor: const Color(0xffdee8f1),
                                        thumbColor: const Color(0xff31466a),
                                        activeColor: const Color(0xFFc9d7e6),
                                        value: _value,
                                        onChanged: (value) {
                                          setState(() {
                                            _value = value;
                                          });
                                        }),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}