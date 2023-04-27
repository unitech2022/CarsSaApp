import 'package:carsa/helpers/functions.dart';
import 'package:carsa/helpers/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_drop_down_widget.dart';
import '../../widgets/text_widget.dart';

class AddCarScreen extends StatefulWidget {
  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  String? currentValue;

  final List<String> _list = ["a", "b", "c"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: IconButton(onPressed: () {
          pop(context);

        }, icon: const Icon(Icons.arrow_back,color: homeColor,),

        ),
        title: const Text(
          "أضف السيارة",
          style: TextStyle(color: homeColor, fontFamily: "pnuR"),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingSymmetric(hor: 20, ver: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FieldSpinner(
                  list: _list,
                  onSelect: (value) {},
                  textHint: "ملاكى",
                  currentValue: currentValue,
                  title: "النمط"),
              FieldSpinner(
                  list: _list,
                  onSelect: (value) {},
                  textHint: "Bmw",
                  currentValue: currentValue,
                  title: "الماركة"),
              FieldSpinner(
                  list: _list,
                  onSelect: (value) {},
                  textHint: "ملاكى",
                  currentValue: currentValue,
                  title: "الموديل"),
              FieldSpinner(
                  list: _list,
                  onSelect: (value) {},
                  textHint: "ملاكى",
                  currentValue: currentValue,
                  title: "سنة الصنع"),
              FieldSpinner(
                  list: _list,
                  onSelect: (value) {},
                  textHint: "ملاكى",
                  currentValue: currentValue,
                  title: "فئة السيارة"),
              const SizedBox(
                height: 35,
              ),

              CustomButton3(
                  text: "اضف السيارة ",
                  fontFamily: "PNUB",
                  onPress: () {

                  },
                  redius: 10,
                  color: homeColor,
                  textColor: Colors.white,
                  fontSize: 18,
                  height: 40)
            ],
          ),
        ),
      ),
    );
  }
}

class FieldSpinner extends StatelessWidget {
  final String? currentValue;
  final List<String> list;
  final String textHint;
  final void Function(dynamic) onSelect;
  final String title;

  FieldSpinner(
      {required this.currentValue,
      required this.list,
      required this.textHint,
      required this.onSelect,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        TextWidget2(
            alginText: TextAlign.start,
            isCustomColor: true,
            width: double.infinity,
            text: title,
            fontFamliy: "pnuB",
            fontSize: 14,
            color: Colors.black),
        const SizedBox(
          height: 10,
        ),
        // Container(
        //   height: 50,
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.circular(10),
        //   ),
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 12.0),
        //     child: CustomDropDownWidget(
        //         currentValue: currentValue,
        //         selectCar: false,
        //         textColor: Colors.black26,
        //         isTwoIcons: false,
        //         iconColor: const Color(0xff515151),
        //         list: list,
        //         onSelect: onSelect,
        //         hint: "ملاكى"),
        //   ),

        // ),



      ],
    );
  }
}
