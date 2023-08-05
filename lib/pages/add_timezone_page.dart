import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:the_clock/models/timezones.dart';
import '../constants.dart';
import '../widgets/neu_rect_widget.dart';
import '../widgets/neu_round_widget.dart';

List addedTimeZones = [];

class AddTimeZonePage extends StatefulWidget {
  const AddTimeZonePage({Key? key}) : super(key: key);

  @override
  State<AddTimeZonePage> createState() => _AddTimeZonePageState();
}

class _AddTimeZonePageState extends State<AddTimeZonePage> {

  String? time = 'loading';

  void setZone() async {
    TimeZone timezone = TimeZone(location: 'Berlin', url: 'Europe/Berlin');
    await timezone.getTime();
    setState(() {
      time = timezone.time;
    });
  }

  final List _allZones = timezones;

  List _foundZones = [];

  @override
  void initState() {
    _foundZones = _allZones;
    setZone();
    super.initState();
  }

  void _filter(String enteredWord) {
    List results = [];
    if (enteredWord.isEmpty) {
      results = _allZones;
    }else{
      results = _allZones.where((zone) => zone.toLowerCase().contains(enteredWord.toLowerCase())).toList();
    }
    setState(() {
      _foundZones = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffe9f1f9),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Row(
              children: [
                NeuRoundWidget(
                    onPress: () {
                      Navigator.pop(context, true);
                    },
                    size: 50,
                    padding: 14,
                    child: Image.asset('assets/images/cancel.png')),
                Expanded(
                  child: NeuRectWidget(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          onChanged: (value) => _filter(value),
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
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _foundZones.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      addedTimeZones.add(_foundZones[index]);
                      Navigator.pop(context, true);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                      decoration: BoxDecoration(
                        color: const Color(0xff31466a).withOpacity(0.1),
                        borderRadius: const BorderRadius.all(Radius.circular(16)),),
                      child: Text(_foundZones[index],style: textStyle,),
                    ),
                  );
                }),
          ),
        ],
      )
    );
  }
}


class TimeZone {
  String location;
  String? time;
  String url;

  TimeZone({ required this.location, this.time, required this.url});

  Future<void> getTime() async{
    final response = await http.get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
    final data = jsonDecode(response.body);

    String datetime = data['datetime'];
    String offset = data['utc_offset'].substring(1, 3);

    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset)));

    time = now.toString();
  }
}
