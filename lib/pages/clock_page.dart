import 'package:flutter/material.dart';
import 'package:the_clock/widgets/neu_rect_widget.dart';
import 'package:the_clock/widgets/neu_round_widget.dart';
import 'package:analog_clock/analog_clock.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import '../constants.dart';
import '../widgets/number_painter.dart';
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                  DigitalClock(
                    hourMinuteDigitTextStyle: TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold, color: fontColor.withOpacity(0.8)
                    ),
                    secondDigitTextStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                    colon: const SizedBox(
                      height: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(Icons.circle, color: Colors.red, size: 3,),
                          Icon(Icons.circle, color: Colors.red, size: 3,),
                        ],
                      ),
                    ),
                  ),
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
            Container(
              margin: const EdgeInsets.only(top: 35),
              height: size.height * 0.3,
              color: const Color(0xffe9f1f9),
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: ListView.builder(
                  itemCount: addedTimeZones.length,
                    itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){},
                      child: Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: NeuRectWidget(
                          child: Center(
                            child: Text(addedTimeZones[index].toString().substring(
                                addedTimeZones[index].toString().indexOf('/', 0) + 1
                            ),style: textStyle,),
                          ),
                        ),
                      ),
                    );
                    }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


