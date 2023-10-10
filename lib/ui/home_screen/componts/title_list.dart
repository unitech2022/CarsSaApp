import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../widgets/custom_text.dart';
class TitleList extends StatelessWidget {
  final text;
final void Function() onPress;

  TitleList(this.text,this.onPress);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:  [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
          child: CustomText(
              family: "pnuB",
              size: 20,
              text: text,
              textColor: Colors.black54,
              weight: FontWeight.bold,
              align: TextAlign.center),
        ),

        /*TextButton(onPressed:onPress, child:CustomText(
            family: "pnuB",
            size: 15,
            text: "الكل",
            textColor: homeColor,
            weight: FontWeight.bold,
            align: TextAlign.center),*/
      ],
    );
  }
}