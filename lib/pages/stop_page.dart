import 'dart:async';
import 'package:flutter/material.dart';
import 'package:the_clock/constants.dart';
import '../widgets/neu_rect_widget.dart';
import '../widgets/neu_round_widget.dart';

class StopPage extends StatefulWidget {
  const StopPage({Key? key}) : super(key: key);

  @override
  State<StopPage> createState() => _StopPageState();
}

class _StopPageState extends State<StopPage> {
  int seconds = 0;
  int minutes = 0;
  int hours = 0;

  String digitSeconds = '00';
  String digitMinutes = '00';
  String digitHours = '00';

  Timer? timer;

  bool started = false;

  List laps = [];

  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  void reset() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;
      digitSeconds = '00';
      digitMinutes = '00';
      digitHours = '00';
      started = false;
      laps.clear();
    });
  }

  void addLap() {
    String lap = '$digitHours:$digitMinutes:$digitSeconds';
    setState(() {
      laps.add(lap);
    });
  }

  void start() {
    started = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;

      if (localSeconds > 59) {
        if (localMinutes > 59) {
          localHours++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSeconds = 0;
        }
      }
      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;
        digitSeconds = (seconds >= 10) ? '$seconds' : '0$seconds';
        digitMinutes = (minutes >= 10) ? '$minutes' : '0$minutes';
        digitHours = (hours >= 10) ? '$hours' : '0$hours';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
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
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(height: 30),
            NeuRectWidget(
              padding: 12,
              child: Center(
                child: Text(
                  '$digitHours:$digitMinutes:$digitSeconds',
                  style: timeStyle,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 350,
              width: 300,
              color: Colors.grey,
              child: ListView.builder(
                itemCount: laps.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Text('0${index + 1} '),
                      Text('${laps[index]}'),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NeuRoundWidget(
                    onPress: () {
                      (!started) ? start() : stop();
                    },
                    size: 50,
                    padding: 14,
                    child: Image.asset((!started)
                        ? 'assets/images/play.png'
                        : 'assets/images/pause.png')),
                NeuRoundWidget(
                    onPress: () {
                      addLap();
                    },
                    size: 50,
                    padding: 14,
                    child: Image.asset('assets/images/flag.png')),
                NeuRoundWidget(
                    onPress: () {
                      reset();
                    },
                    size: 50,
                    padding: 14,
                    child: Image.asset('assets/images/stop.png')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
