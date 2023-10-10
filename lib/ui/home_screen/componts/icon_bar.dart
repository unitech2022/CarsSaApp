import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconButtonController extends StatefulWidget {
  final void Function() onPress;
  final IconData icon;
  final Color color;
 final double size;

  IconButtonController(
      {required this.onPress,
      required this.icon,
      required this.color,
      this.size = 33});

  @override
  State<IconButtonController> createState() => _IconButtonControllerState();
}

class _IconButtonControllerState extends State<IconButtonController> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: widget.onPress,
            icon: Icon(
              widget.icon,
              color: widget.color,
              size: widget.size,
            )),
      ),
    );
  }
}

class IconButtonController2 extends StatelessWidget {
  final void Function() onPress;
  final IconData icon;
  final Color color;
 final double size;

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
