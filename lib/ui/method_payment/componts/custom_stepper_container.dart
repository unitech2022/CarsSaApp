import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../helpers/styles.dart';
import '../../../widgets/custom_text.dart';

class CustomStepperContainer extends StatelessWidget {
  final String text, number;
  final bool isDone;

  const CustomStepperContainer(
      {required this.text, required this.isDone, required this.number});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              color: isDone ? homeColor : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: homeColor, width: 1)),
          child: Center(
            child: isDone
                ? const Icon(
              Icons.done,
              color: Colors.white,
            )
                : Text(
              number,
              style: const TextStyle(
                color: homeColor,
                fontSize: 18,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomText(
            family: "pnuB",
            size: 12,
            text: text,
            textColor: homeColor,
            weight: FontWeight.w300,
            align: TextAlign.center)
      ],
    );
  }
}