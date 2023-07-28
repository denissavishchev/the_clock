import 'package:flutter/material.dart';
import 'package:the_clock/main_page.dart';
import '../constants.dart';
import '../widgets/neu_round_widget.dart';

class AddAlarmPage extends StatefulWidget {
  const AddAlarmPage({Key? key}) : super(key: key);

  @override
  State<AddAlarmPage> createState() => _AddAlarmPageState();
}

class _AddAlarmPageState extends State<AddAlarmPage> {

  // bool _value = true;

  int hour = 0;
  int minute = 0;

  late FixedExtentScrollController _minController;
  late FixedExtentScrollController _hourController;

  @override
  void initState() {
    _minController = FixedExtentScrollController();
    _hourController = FixedExtentScrollController();
    super.initState();
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
                      onPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MainPage()));
                      },
                      size: 50,
                      padding: 14,
                      child: Image.asset('assets/images/cancel.png')),
                  Text('Alarm in $hour $minute'),
                  NeuRoundWidget(
                      onPress: () {

                      },
                      size: 50,
                      padding: 14,
                      child: Image.asset('assets/images/ok.png')),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 100,
                    child: ScrollConfiguration(
                      behavior: const ScrollBehavior().copyWith(overscroll: false),
                      child: ListWheelScrollView.useDelegate(
                        controller: _hourController,
                        itemExtent: 60,
                        perspective: 0.005,
                        diameterRatio: 2.5,
                        onSelectedItemChanged: (value){
                          setState(() {
                            hour = value;
                          });
                        },
                        physics: const FixedExtentScrollPhysics(),
                        childDelegate: ListWheelChildBuilderDelegate(
                          childCount: 24,
                          builder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Center(
                                child: Text(
                                    index < 10 ? '0$index' : index.toString(),
                                    style: timeStyle),
                              ),
                            );
                          }
                        ),

                      ),
                    ),
                  ),
                  const SizedBox(width: 50),
                  SizedBox(width: 100,
                    child: ScrollConfiguration(
                      behavior: const ScrollBehavior().copyWith(overscroll: false),
                      child: ListWheelScrollView.useDelegate(
                        controller: _minController,
                        itemExtent: 60,
                        perspective: 0.005,
                        diameterRatio: 2.5,
                        onSelectedItemChanged: (value){
                          setState(() {
                            minute = value;
                          });
                        },
                        physics: const FixedExtentScrollPhysics(),
                        childDelegate: ListWheelChildBuilderDelegate(
                          childCount: 60,
                          builder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Center(
                                child: Text(
                                    index < 10 ? '0$index' : index.toString(),
                                    style: timeStyle),
                              ),
                            );
                          }
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
