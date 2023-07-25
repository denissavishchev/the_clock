import 'package:flutter/material.dart';
import 'package:the_clock/widgets/neu_round_widget.dart';
import 'package:analog_clock/analog_clock.dart';

import '../widgets/number_painter.dart';

class ClockPage extends StatelessWidget {
  const ClockPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffe9f1f9),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  NeuRoundWidget(
                      onPress: () {},
                      size: 50,
                      padding: 14,
                      child: Image.asset('assets/images/gear.png')),
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
          ],
        ),
      ),
    );
  }
}


