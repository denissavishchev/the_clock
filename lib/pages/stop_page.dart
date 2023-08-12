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
  final stopwatch = Stopwatch();

  String text = '00:00:00';

  void timeWatch(){
    stopwatch.start();
    print(stopwatch.isRunning);
    print(stopwatch.elapsed);
    setState(() {
      text = stopwatch.elapsed.toString();
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
            const SizedBox(height: 90),
            NeuRectWidget(
              padding: 12,
              child: Center(
                child: Text(
                  text,
                  style: timeStyle,
                ),
              ),
            ),
            const SizedBox(height: 90),
            NeuRoundWidget(
                onPress: timeWatch,
                size: 50,
                padding: 14,
                child: Image.asset('assets/images/play.png')),
          ],
        ),
      ),
    );
  }
}