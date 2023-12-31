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

  Timer timer = Timer.periodic(const Duration(seconds: 1), (timer){});

  bool started = false;

  List laps = [];

  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
      timer.cancel();
    super.dispose();
  }

  void stop() {
      timer.cancel();
    setState(() {
      started = false;
    });
  }

  void reset() {
    timer.cancel();
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
    scrollController.animateTo(
        scrollController.position.maxScrollExtent + 50,
        duration: const Duration(milliseconds: 10),
        curve: Curves.linear);
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
              height: MediaQuery.of(context).size.height * 0.4,
              width: 300,
              color: backgroundColor,
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ListView.builder(
                    controller: scrollController,
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: laps.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: NeuRectWidget(
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(index < 9 ? '0${index + 1}' : '${index + 1}', style: helpTextStyle,),
                              Text('${laps[index]}', style: textStyle,),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
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
