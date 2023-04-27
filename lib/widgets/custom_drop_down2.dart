
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/styles.dart';


class CustomDropDownWidget2 extends StatefulWidget {
  final  List<dynamic> list;
  final Function onSelect;
  final double height;
  final String hint;

   CustomDropDownWidget2({required this.height,required this.list, required this.onSelect,required this.hint});

  @override
  _CustomDroopDownWidgetState createState() => _CustomDroopDownWidgetState();
}

class _CustomDroopDownWidgetState extends State<CustomDropDownWidget2> {
  dynamic currentValue;


  @override
  Widget build(BuildContext context) {
    return DropdownButton<dynamic>(

        hint: Text(widget.hint,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontFamily: 'pnuB',
              fontSize: 16,
              color: homeColor,
              height: 2.2,
            )),
            isExpanded: true,
        style: const TextStyle(
          fontFamily: 'pnuB',
          fontSize: 16,
          color: homeColor,
          height: 2.2,
          
        ),
        value: currentValue,
        icon: const SizedBox(),
        iconSize: 25,
        underline: const SizedBox(),
        onChanged: (value) {
          setState(() {
            currentValue = value;
          });

          widget.onSelect(value!);
        },
        items:
        widget.list.map<DropdownMenuItem<dynamic>>((dynamic value) {
          return DropdownMenuItem<dynamic>(
            value: value,
            child: Container(
              color: Colors.white,
              child: Text(
                value.name,
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 16,color: homeColor),
              ),
            ),
          );
        }).toList());
  }


}