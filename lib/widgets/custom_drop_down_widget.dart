import 'package:carsa/helpers/styles.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';


class CustomDropDownWidget extends StatefulWidget {
  final List<String> list;
  final Function(dynamic) onSelect;
  final String hint;
  final bool isTwoIcons;

  final Color iconColor, textColor;
final dynamic currentValue;
  final bool selectCar;


  const CustomDropDownWidget(
      {this.selectCar=false,

       required this.currentValue,

      required this.textColor,
      required this.iconColor,

      this.isTwoIcons = false,
      required this.list,
      required this.onSelect,
      required this.hint});

  @override
  _CustomDroopDownWidgetState createState() => _CustomDroopDownWidgetState();
}

class _CustomDroopDownWidgetState extends State<CustomDropDownWidget> {
  String? currentValue;


  // getString(item){
  //   if(widget.selectType==0){
  //     return item.typ!;
  //   }else if(widget.selectType==1){
  //     return item.model;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,

        items: widget.list
            .map((item) =>
                DropdownMenuItem<dynamic>(value: item,

                    child:

                    Text(
                     item,
                      style:  const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    )))
            .toList(),
        value: widget.currentValue,
        onChanged:widget.onSelect
        ,
        icon:  const Icon(
          Icons.keyboard_arrow_down_sharp,color: homeColor,
        ),
        iconSize: 18,
        iconEnabledColor: Colors.white,
        iconDisabledColor: Colors.grey,
        buttonHeight: 50,
        buttonWidth: double.infinity,

        buttonDecoration: const BoxDecoration(

          color: Colors.white,
        ),
        itemHeight: 40,

        itemPadding: const EdgeInsets.only(left: 14, right: 14),
        dropdownMaxHeight: 200,
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
        ),
        dropdownElevation: 8,
        scrollbarRadius: const Radius.circular(40),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
        offset: const Offset(-20, 0),
        hint: Text(widget.hint,style: const TextStyle(
          fontFamily: "pnuR",fontSize: 13
        ),),
      ),
    );
  }
}
