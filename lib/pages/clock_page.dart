import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_clock/models/boxes.dart';
import 'package:the_clock/models/clock_model.dart';
import 'package:the_clock/widgets/neu_rect_widget.dart';
import 'package:the_clock/widgets/neu_round_widget.dart';
import 'package:analog_clock/analog_clock.dart';
import '../constants.dart';
import '../widgets/number_painter.dart';
import '../widgets/time_and_date_widget.dart';
import 'add_timezone_page.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({Key? key}) : super(key: key);

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTimeZonePage()),
    );
    if (result) {
      setState((){});
    }
  }
  Future deleteZone(int index, Box<ClockModel> box) {
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
    DateTime now = DateTime.now();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffe9f1f9),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
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
                        _navigateAndDisplaySelection(context);
                      },
                      size: 50,
                      padding: 14,
                      child: Image.asset('assets/images/add.png')),
                ],
              ),
            ),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  NeuRoundWidget(size: size.width * 0.8),
                  NeuRoundWidget(size: size.width * 0.4),
              AnalogClock(
                width: size.width * 0.5,
                height: size.width * 0.5,
                isLive: true,
                hourHandColor: const Color(0xff31466a).withOpacity(0.7),
                minuteHandColor: const Color(0xff31466a),
                showSecondHand: true,
                numberColor: Colors.black87,
                showNumbers: false,
                showAllNumbers: false,
                textScaleFactor: 1.4,
                showTicks: false,
                showDigitalClock: false,
                datetime: DateTime.now(),
              ),
              SizedBox(
                width: size.width * 0.8,
                height: size.width * 0.8,
                child: CustomPaint(
                  painter: NumbersPainter(),
                ),
              )
                ],
              ),
            ),
            ValueListenableBuilder(
                valueListenable: Boxes.addClockToBase().listenable(),
                builder: (context, box, _) {
                  final zones = box.values.toList().cast<ClockModel>();
                  return Container(
                    margin: const EdgeInsets.only(top: 35),
                    height: size.height * 0.3,
                    color: const Color(0xffe9f1f9),
                    child: ScrollConfiguration(
                      behavior: const ScrollBehavior().copyWith(overscroll: false),
                      child: ListView.builder(
                          itemCount: zones.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onLongPress: (){
                                deleteZone(index, box);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 24),
                                child: NeuRectWidget(
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(now.add(Duration(hours: int.parse(zones[index].offset) - 2)).toString()),
                                          Text(zones[index].zone),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(zones[index].zone.toString().substring(
                                              zones[index].zone.toString().indexOf('/', 0) + 1
                                          ),style: textStyle,),
                                          Text(((int.parse(zones[index].offset)) - 2).toString()),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}


