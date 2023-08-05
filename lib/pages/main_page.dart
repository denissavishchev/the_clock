import 'package:flutter/material.dart';
import 'package:the_clock/pages/alarm_page.dart';
import 'package:the_clock/pages/clock_page.dart';
import 'package:the_clock/pages/stop_page.dart';
import 'package:the_clock/pages/timer_page.dart';
import 'package:hive/hive.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  final PageController _pageController = PageController(initialPage: 0);

  int _activePage = 0;

  final List _pages = [
    const AlarmPage(),
    const ClockPage(),
    const StopPage(),
    const TimerPage(),
  ];

  final List _icons = ['alarm', 'clock', 'stop', 'sand'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
              onPageChanged: (int page) {
              setState(() {
                _activePage = page;
              });},
              itemCount: _pages.length,
              itemBuilder: (context, index) {
              return _pages[index % _pages.length];
              }),
          Positioned(
            bottom: 20,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                      _pages.length, (index) =>
                      GestureDetector(
                        onTap: (){
                          _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          padding: EdgeInsets.all(_activePage == index ? 3 : 18),
                          decoration: const BoxDecoration(
                              color: Color(0xFFe3edf7),
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 20,
                                    offset: Offset(-10, -10)
                                ),
                                BoxShadow(
                                    color: Color(0xFFc9d7e6),
                                    blurRadius: 20,
                                    offset: Offset(10, 10)
                                ),
                              ]
                          ),
                          child: _activePage == index
                              ? Container(
                                padding: const EdgeInsets.all(16),
                                decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(color: Color(0xFFe3edf7), blurRadius: 1, spreadRadius: 0),
                                  BoxShadow(color: Colors.white, blurRadius: 20, spreadRadius: 5),
                                ],
                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                color: Color(0xFFe3edf7),
                                gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFFe3edf7),
                                  Colors.white,
                                ],
                              ),
                            ),
                            child: Image.asset('assets/images/${_icons[index]}.png'),
                          )
                              : Image.asset('assets/images/${_icons[index]}.png')
                        ),
                      )),
                ),
              ))
        ],
      ),
    );
  }
}
