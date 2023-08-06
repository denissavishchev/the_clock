import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_clock/constants.dart';
import 'package:the_clock/functions.dart';
import 'package:the_clock/models/alarm_model.dart';
import 'package:the_clock/pages/add_alarm_page.dart';
import '../models/boxes.dart';
import '../widgets/neu_rect_widget.dart';
import '../widgets/neu_round_widget.dart';
import '../widgets/time_and_date_widget.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {

  Future deleteAlarm(int index, Box<AlarmModel> box) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: const BoxDecoration(
                      color: Color(0xffe9f1f9),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      )
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        box.deleteAt(index);
                        Navigator.of(context).pop();
                      },
                      child: NeuRoundWidget(
                        padding: 14,
                        size: 50,
                        child: Image.asset('assets/images/bin_red.png'),
                      ),
                    ),
                  ),
                );
              }
          );
        });
  }

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
                  const TimeAndDateWidget(),
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
                          final days = alarms[index].days;
                          var activeDays = [];
                          days.forEach((k, v) {
                            if(v == true){
                              activeDays.add(k);
                            }
                          });
                          return GestureDetector(
                            onLongPress: () {
                              deleteAlarm(index, box);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 24.0),
                              child: NeuRectWidget(
                                height: 75,
                                padding: 12,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text('${alarms[index].hour.toString().padLeft(2, '0')}:${alarms[index].minute.toString().padLeft(2, '0')}',
                                                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                                              ),
                                              const SizedBox(width: 10,),
                                              SizedBox(
                                                width: 150,
                                                child: Text(alarms[index].label == 'Enter label'
                                                    ? ''
                                                    : alarms[index].label.toString(),
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold,
                                                      color: fontColor.withOpacity(0.7)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 210,
                                            child: Row(
                                              children: [
                                                Text('In ${timeUntil(alarms[index].hour, alarms[index].minute)}'),
                                                const SizedBox(width: 28,),
                                                alarms[index].repeat == 'Custom'
                                                    ? Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: List.generate(activeDays.length, (index) =>
                                                        Padding(
                                                          padding: const EdgeInsets.only(right: 1.0),
                                                          child: Text(activeDays[index],
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.bold,
                                                                  color: fontColor.withOpacity(0.8))),
                                                      )))
                                                    : Text(alarms[index].repeat == 'Once'
                                                    ? ''
                                                    : alarms[index].repeat,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: fontColor.withOpacity(0.8)),),
                                              ],
                                            ),
                                          ),
                                        ],
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
                                            value: alarms[index].isActive,
                                            onChanged: (value) {
                                              if (alarms[index].isActive == false){
                                                setState(() {
                                                  alarms[index].isActive = true;
                                                  box.putAt(alarms.indexOf(alarms[index]), alarms[index]);
                                                });
                                              }else{
                                                setState(() {
                                                  alarms[index].isActive = false;
                                                  box.putAt(alarms.indexOf(alarms[index]), alarms[index]);
                                                });
                                              }
                                            }),
                                      )
                                    ],
                                  ),
                                ),
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
