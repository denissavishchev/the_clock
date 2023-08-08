import 'package:flutter/material.dart';

import '../constants.dart';

class NeuRectWidget extends StatelessWidget {
  const NeuRectWidget({Key? key,
    this.child,
    this.onPress,
    this.distance = 10,
    this.padding = 0.0,
    this.height = 65,
  }) : super(key: key);

  final Widget? child;
  final VoidCallback? onPress;
  final double distance;
  final double padding;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        width: MediaQuery.of(context).size.width,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: padding),
        decoration: BoxDecoration(
            color: boxColor,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                  color: Colors.white,
                  blurRadius: 20,
                  offset: Offset(-distance, -distance)
              ),
              BoxShadow(
                  color: shadowColor,
                  blurRadius: 20,
                  offset: Offset(distance, distance)
              ),
            ]
        ),
        child: child,
      ),
    );
  }
}
