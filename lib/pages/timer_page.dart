import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import '../constants.dart';
import '../widgets/neu_round_widget.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> with TickerProviderStateMixin{

  late AnimationController _controller;

  bool isPlaying = false;

  double progress = 1.0;

  void notify(){
    if(countText == '0:00:00') {
      FlutterRingtonePlayer.playNotification();
    }
  }

  String get countText{
    Duration count = _controller.duration! * _controller.value;
    return _controller.isDismissed
            ? '${_controller.duration!.inHours}:${(_controller.duration!.inMinutes % 60).toString()
        .padLeft(2, '0')}:${(_controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
            : '${count.inHours}:${(count.inMinutes % 60).toString()
        .padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 60));

    _controller.addListener(() {
      notify();
      if(_controller.isAnimating){
        setState(() {
          progress = _controller.value;
        });
      }else{
        setState(() {
          progress = 1.0;
          setState(() {
            isPlaying = false;
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                  const Spacer(),
                  NeuRoundWidget(
                      onPress: () {},
                      size: 50,
                      padding: 14,
                      child: Image.asset('assets/images/gear.png')),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size. height * 0.7,
              color: backgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      NeuRoundWidget(
                          size: 320,
                          distance: 10,
                          blur: 20,
                        child: Container(
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(color: boxColor, blurRadius: 5),
                              BoxShadow(color: Colors.white, blurRadius: 20, spreadRadius: 5),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(160)),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                boxColor,
                                Colors.white,
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 280,
                        height: 280,
                        child: CircularProgressIndicator(
                          value: 1 - progress,
                          backgroundColor: backgroundColor,
                          strokeWidth: 20,
                          color: purple,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          if(_controller.isDismissed){
                            showModalBottomSheet(
                                context: context,
                                builder: (context){
                                  return SizedBox(
                                    height: 300,
                                    child: CupertinoTimerPicker(
                                      initialTimerDuration: _controller.duration!,
                                      onTimerDurationChanged: (time){
                                        setState(() {
                                          _controller.duration = time;
                                        });
                                      },
                                    ),
                                  );
                                });
                          }
                        },
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return Text(countText, style: timeStyle,);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      NeuRoundWidget(
                          onPress: () {
                            if(_controller.isAnimating){
                              _controller.stop();
                              setState(() {
                                isPlaying = false;
                              });
                            }else{
                              _controller.reverse(from: _controller.value == 0
                                  ? 1.0
                                  : _controller.value);
                              setState(() {
                                isPlaying = true;
                              });
                            }
                          },
                          size: 50,
                          padding: 14,
                          child: Image.asset(isPlaying
                              ? 'assets/images/pause.png'
                              : 'assets/images/play.png')),
                      NeuRoundWidget(
                          onPress: () {
                            _controller.reset();
                            setState(() {
                              isPlaying = false;
                            });
                          },
                          size: 50,
                          padding: 14,
                          child: Image.asset('assets/images/stop.png')),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}