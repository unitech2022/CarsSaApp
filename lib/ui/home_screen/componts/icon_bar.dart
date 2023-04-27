import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconButtonController extends StatelessWidget {
  final void Function() onPress;
  final IconData icon;
  final Color color;
  double size;

  IconButtonController(
      {required this.onPress,
      required this.icon,
      required this.color,
      this.size = 33});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: onPress,
            icon: Icon(
              icon,
              color: color,
              size: size,
            )),
      ),
    );
  }
}

class IconButtonController2 extends StatelessWidget {
  final void Function() onPress;
  final IconData icon;
  final Color color;
  double size;

  IconButtonController2(
      {required this.onPress,
      required this.icon,
      required this.color,
      this.size = 30});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: GestureDetector(
          onTap: onPress,
          child: Icon(
            icon,
            color: color,
            size: size,
          )),
    );
  }
}
