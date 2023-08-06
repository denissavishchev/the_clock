import 'package:flutter/material.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:intl/intl.dart';
import '../constants.dart';

class TimeAndDateWidget extends StatelessWidget {
  const TimeAndDateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    String date = DateFormat('EEE d MMM yyyy').format(now);

    return Column(
      children: [
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
        Text(date, style: helpTextStyle.copyWith(fontSize: 16),)
      ],
    );
  }
}