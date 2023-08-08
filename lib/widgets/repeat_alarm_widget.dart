import 'package:flutter/material.dart';

import '../constants.dart';

class RepeatAlarmWidget extends StatelessWidget {
  const RepeatAlarmWidget({
    super.key, required this.name, required this.onPress, required this.isChecked,
  });

  final String name;
  final Function() onPress;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onPress();
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: isChecked ? fontColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name, style: textStyle,),
            isChecked
                ? SizedBox(
                  width: 16,
                  height: 16,
                  child: Image.asset('assets/images/ok.png'))
                : Container(),
          ],
        ),
      ),
    );
  }
}