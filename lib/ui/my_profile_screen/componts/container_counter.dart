import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/text_widget.dart';

class ContainerCounter extends StatelessWidget {
  final String text, count;
  final IconData icon;

  const ContainerCounter(
      {Key? key, required this.text, required this.count, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextWidget3(
                    alginText: TextAlign.start,
                    isCustomColor: true,
                    text: count,
                    fontFamliy: "pnuB",
                    fontSize: 23,
                    color: Colors.white),
                Icon(
                  icon,
                  color: Colors.white,
                  size: 30,
                )
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            TextWidget3(
                alginText: TextAlign.start,
                isCustomColor: true,
                text: text,
                fontFamliy: "pnuL",
                fontSize: 12,
                color: Colors.white),
          ],
        ));
  }
}