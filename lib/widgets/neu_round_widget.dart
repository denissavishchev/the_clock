import 'package:flutter/material.dart';


class NeuRoundWidget extends StatelessWidget {
  const NeuRoundWidget({Key? key,
    required this.size,
    this.onPress,
    this.blur = 20,
    this.distance = 10,
    this.child,
    this.padding = 0.0,
  }) : super(key: key);

  final double size;
  final Widget? child;
  final VoidCallback? onPress;
  final double blur;
  final double distance;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: size,
        height: size,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: const Color(0xFFe3edf7),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              blurRadius: blur,
              offset: Offset(-distance, -distance)
            ),
            BoxShadow(
                color: const Color(0xFFc9d7e6),
                blurRadius: blur,
                offset: Offset(distance, distance)
            ),
          ]
        ),
        child: child,
      ),
    );
  }
}
