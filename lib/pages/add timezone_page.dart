import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:the_clock/models/timezones.dart';

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

  @override
  void initState() {
    setZone();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: timezones.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                addedTimeZones.add(timezones[index]);
                Navigator.pop(context, true);
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(timezones[index]),
              ),
            );
          })
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