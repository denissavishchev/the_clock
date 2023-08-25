import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import '../constants.dart';
import '../widgets/neu_rect_widget.dart';
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
              height: MediaQuery.of(context).size. height * 0.5,
              color: shadowColor,
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 300,
                          height: 300,
                          child: CircularProgressIndicator(
                            value: progress,
                            backgroundColor: purple,
                            strokeWidth: 10,
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
                              return Text(countText);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: (){
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
                          icon: isPlaying
                                  ? const Icon(Icons.pause, size: 50,)
                                  : const Icon(Icons.play_arrow, size: 50,)),
                      IconButton(
                          onPressed: (){
                            _controller.reset();
                            setState(() {
                              isPlaying = false;
                            });
                          },
                          icon: const Icon(Icons.stop, size: 50,)),
                    ],
                  ),
                  const SizedBox(height: 12,)
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Row(
              children: [
                Expanded(
                  child: NeuRectWidget(
                    height: 50,
                    child: Center(
                      child: Text(
                        'Start',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: NeuRectWidget(
                    height: 50,
                    child: Center(
                      child: Text(
                        'Reset',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: purple
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}