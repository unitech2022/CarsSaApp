import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../helpers/styles.dart';
import '../../../widgets/text_widget.dart';

class ContainerProfileText extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function() onPress;
  final isIcon;

  const ContainerProfileText(
      {required this.text,
        required this.icon,
        required this.onPress,
        this.isIcon = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        height: 60,
        margin: const EdgeInsets.only(bottom: 10),
        padding: paddingSymmetric(hor: 20, ver: 5),
        child: Center(
          child: Row(
            children: [
              isIcon
                  ? SizedBox()
                  : Icon(
                icon,
                color: homeColor,
                size: 30,
              ),
              const SizedBox(
                width: 25,
              ),
              TextWidget3(
                  alginText: TextAlign.start,
                  isCustomColor: true,
                  text: text,
                  fontFamliy: "pnuL",
                  fontSize: 18,
                  color: homeColor),
            ],
          ),
        ),
      ),
    );
  }
}