import 'package:flutter/material.dart';

class NavBarWidget extends StatelessWidget {
  const NavBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      width: MediaQuery.of(context).size.width,
      height: 60,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Button(child: Image.asset('assets/images/clock.png'),),
          Button(child: Image.asset('assets/images/alarm.png'),),
          Button(child: Image.asset('assets/images/stop.png'),),
          Button(child: Image.asset('assets/images/sand.png'),),
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({Key? key, this.child, this.onPress}) : super(key: key);

  final Widget? child;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 60,
        height: 60,
        padding: const EdgeInsets.all(18),
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
        child: child,
      ),
    );
  }
}
