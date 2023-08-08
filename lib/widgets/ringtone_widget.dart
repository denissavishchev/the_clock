import 'package:flutter/material.dart';
import 'package:the_clock/widgets/neu_round_widget.dart';

import '../constants.dart';

class RingtoneWidget extends StatelessWidget {
  const RingtoneWidget({
    super.key,
    required this.name,
    required this.onPress,
    required this.isChecked,
    required this.onTap,
  });

  final String name;
  final Function() onPress;
  final Function() onTap;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          SizedBox(
            width: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: NeuRoundWidget(
                      size: 40,
                    padding: 8,
                    child: Image.asset('assets/images/note.png')),
                ),
                GestureDetector(
                  onTap: (){
                    onPress();
                    Navigator.pop(context);
                  },
                  child: NeuRoundWidget(
                      size: 40,
                      padding: 8,
                    child: Image.asset('assets/images/ok.png')),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}