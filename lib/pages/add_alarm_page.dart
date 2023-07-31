import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_clock/models/alarm_model.dart';
import 'package:the_clock/models/boxes.dart';
import 'package:the_clock/pages/main_page.dart';
import 'package:the_clock/widgets/neu_rect_widget.dart';
import 'package:the_clock/widgets/ringtone_widget.dart';
import '../constants.dart';
import '../functions.dart';
import '../widgets/neu_round_widget.dart';
import '../widgets/repeat_alarm_widget.dart';
import 'package:just_audio/just_audio.dart';

class AddAlarmPage extends StatefulWidget {
  const AddAlarmPage({Key? key}) : super(key: key);

  @override
  State<AddAlarmPage> createState() => _AddAlarmPageState();
}

class _AddAlarmPageState extends State<AddAlarmPage> {

  bool _deleteAfter = true;
  String _repeatAlarm = 'Once';
  String _label = 'Enter label';
  late String _ringtone = sounds[0];

  final Map<String, bool> _daysOfWeek = {
    'Mo':false,
    'Tu':false,
    'We':false,
    'Th':false,
    'Fr':false,
    'Sa':false,
    'Su':false
  };

  List sounds = [
    'Abbey Cadence',
    'African Drums',
    'Bad Ideas',
    'Corncob',
    'Discovery',
    'Home',
    'Light Sting'
    ];

  int hour = 0;
  int minute = 0;
  AudioPlayer player = AudioPlayer();

  late FixedExtentScrollController _minController;
  late FixedExtentScrollController _hourController;
  late TextEditingController _labelController;

  void addAlarm() {
    final alarms = AlarmModel()
        ..hour = hour
        ..minute = minute
        ..ringtone = _ringtone
        ..repeat = _repeatAlarm
        ..days = _daysOfWeek
        ..deleteAfter = _deleteAfter
        ..label = _label;
      final box = Boxes.addAlarmToBase();
      box.add(alarms);
  }

  Future repeatWindow() {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: const BoxDecoration(
                      color: Color(0xffe9f1f9),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RepeatAlarmWidget(
                          name: 'Once',
                          onPress: () => updateRepeat('Once'),
                          isChecked: _repeatAlarm == 'Once',
                      ),
                      RepeatAlarmWidget(
                          name: 'Daily',
                          onPress: () => updateRepeat('Daily'),
                        isChecked: _repeatAlarm == 'Daily',
                      ),
                      RepeatAlarmWidget(
                          name: 'Monday to Friday',
                          onPress: () => updateRepeat('Monday to Friday'),
                        isChecked: _repeatAlarm == 'Monday to Friday',
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: _repeatAlarm == 'Custom'
                              ? const Color(0xff31466a).withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: const BorderRadius.all(Radius.circular(16)),),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Custom', style: textStyle,),
                            Row(
                              children: List.generate(7, (index){
                                return GestureDetector(
                                  onTap: (){
                                    setState((){
                                      _repeatAlarm = 'Custom';
                                      _daysOfWeek.update(_daysOfWeek.keys.toList()[index], (value) => !value);
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: NeuRoundWidget(size: 30,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Center(
                                              child: Text(
                                                _daysOfWeek.keys.toList()[index],
                                                style: _daysOfWeek.values.toList()[index] && _repeatAlarm == 'Custom'
                                                    ? helpTextStyle.copyWith(color: Colors.red)
                                                    : helpTextStyle,
                                              )),
                                        )),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      NeuRoundWidget(
                        onPress: (){
                          updateRepeat('Custom');
                          Navigator.pop(context);
                        },
                          size: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Image.asset('assets/images/ok.png'),
                          )),
                    ],
                  ),
                );
              }
          );
        });
  }

  Future ringtoneWindow() {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: const BoxDecoration(
                      color: Color(0xffe9f1f9),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      )
                  ),
                  child: ListView.builder(
                    itemCount: sounds.length,
                      itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: RingtoneWidget(
                            name: sounds[index],
                            onTap: () async {
                              if(player.playing) {
                                await player.stop().then((value) {
                                  player.setAsset('assets/audio/${sounds[index]}.mp3');
                                  player.play();
                                });
                              }else{
                                player.setAsset('assets/audio/${sounds[index]}.mp3');
                                await player.play();
                              }
                            },
                            onPress: () {
                              player.stop();
                              updateRingtone(sounds[index]);
                            },
                            isChecked: _ringtone == sounds[index],
                            ),
                      );
                      })
                );
              }
          );
        });
  }

  Future labelWindow() {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: StatefulBuilder(
                builder: (context, setState) {
                  return Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: const BoxDecoration(
                          color: Color(0xffe9f1f9),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          NeuRectWidget(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: TextField(
                                    controller: _labelController,
                                    cursorColor: fontColor,
                                    autofocus: true,
                                    style: const TextStyle(fontSize: 24),
                                    decoration: const InputDecoration(
                                      isCollapsed: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent)
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent)
                                      )
                                    ),
                                  ),
                                ),
                              ),
                          ),
                          const SizedBox(height: 15,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(width: 50,),
                                GestureDetector(
                                  onTap: (){
                                    updateLabel(_labelController.text);
                                    Navigator.of(context).pop();
                                  },
                                  child: NeuRoundWidget(
                                    size: 50,
                                    padding: 14,
                                    child: Image.asset('assets/images/ok.png'),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                  );
                }
            ),
          );
        });
  }

  void updateRepeat(String repeat) {
    setState(() {
      _repeatAlarm = repeat;
    });
  }

  void updateRingtone(String ringtone) {
    setState(() {
      _ringtone = ringtone;
    });
  }

  void updateLabel(String label) {
    setState(() {
      _label = label;
    });
  }

  @override
  void initState() {
    _minController = FixedExtentScrollController();
    _hourController = FixedExtentScrollController();
    _labelController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xffe9f1f9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height * 0.95,
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
                      Text('Alarm in ${timeUntil(hour, minute)}', style: textStyle,),
                      NeuRoundWidget(
                          onPress: () {
                            addAlarm();
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const MainPage()));
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
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(height: 10,),
                      GestureDetector(
                        onTap: (){
                          ringtoneWindow();
                        },
                        child: NeuRectWidget(
                          padding: 12,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Ringtone',
                                style: textStyle),
                              Row(
                                children: [
                                  Text(_ringtone, style: helpTextStyle,),
                                  Icon(Icons.arrow_forward_ios, size: 16, color: fontColor.withOpacity(0.7))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          repeatWindow();
                        },
                        child: NeuRectWidget(
                          padding: 12,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Repeat', style: textStyle),
                              Row(
                                children: [
                                  Text(_repeatAlarm, style: helpTextStyle,),
                                  Icon(Icons.arrow_forward_ios, size: 16, color: fontColor.withOpacity(0.7))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      NeuRectWidget(
                        padding: 12,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Delete after goes off', style: textStyle),
                            Container(
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(16)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white,
                                        blurRadius: 10,
                                        offset: Offset(-5, -5)),
                                    BoxShadow(
                                        color: Color(0xFFc9d7e6),
                                        blurRadius: 10,
                                        offset: Offset(5, 5)),
                                  ]),
                              child: CupertinoSwitch(
                                  trackColor: const Color(0xffdee8f1),
                                  thumbColor: const Color(0xff31466a),
                                  activeColor: const Color(0xFFc9d7e6),
                                  value: _deleteAfter,
                                  onChanged: (value) {
                                    setState(() {
                                      _deleteAfter = value;
                                    });
                                  }),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          labelWindow();
                        },
                        child: NeuRectWidget(
                          padding: 12,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Label', style: textStyle),
                              Row(
                                children: [
                                  Text(_label, style: helpTextStyle,),
                                  Icon(Icons.arrow_forward_ios, size: 16, color: fontColor.withOpacity(0.7),)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

